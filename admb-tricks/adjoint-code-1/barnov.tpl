// |--------------------------------------------------------------------------|
// | An example of developing adjoint code for the Baranov catch equation.    |
// | Author: Steven Martell     											  |
// | email:  stevem@iphc.int 												  |
// |--------------------------------------------------------------------------|
// | This is a simple simulation model that first generates catch  given ft.
// | Then attempts to estimate the model parameters by conditioning the model
// | based on the observed catch.
// | 
// | The model equations are as follows.
// | N_{t+1} = N_t * exp(-Z_t)  + R_{t}
// | R_{t}   = a*N_{t-1}/(1+b*N_{t-1})
// | Z_{t}   = M + F_t
// | C_{t}   = N_t * F_t * (1 - exp(-Z_t)) / Z_t
// | y_{t}   = q N_t * exp(-0.5 Z_t + \epsilon_t) 
// |
// | F_t is solved for numerically using Newton-Rahpson, or using Pope's approx.
// | Uncomment lines 79, 82, or 85 to test the different methods. 
// | The ADJoint code is called from line 85.


DATA_SECTION
	int n;
	!! n = 30;
	vector ct(1,n);
	vector yt(1,n);
	


PARAMETER_SECTION
	init_number log_no(1);
	init_bounded_number h(0.2,1.0,1);
	init_number log_m(1);
	init_number log_q(1);


	!! log_no = log(100);
	!! h      = 0.75;
	!! log_m  = log(0.20);
	!! log_q  = log(0.10);

	objective_function_value f;

	number no;
	number m;
	number reck;
	number a;
	number b;
	number q;

	vector nt(1,n+1);
	vector rt(1,n);
	vector zt(1,n);
	vector ft(1,n);
	vector epsilon(1,n);

PRELIMINARY_CALCS_SECTION

	simulateData();

PROCEDURE_SECTION
	runModel();

FUNCTION runModel
	int i;
	no    = mfexp(log_no);
	m     = mfexp(log_m);
	q     = mfexp(log_q);
	reck  = 4.*h/(1.-h);
	a     = reck*(1.-mfexp(-m));
	b     = (reck-1.)/no;
	nt(1) = no;
	rt(1) = no*(1.-mfexp(-m));
	// ft    = 0.15;

	for( i = 1; i <= n; i++ )
	{
		// Popes approximation.
		//ft(i)   = ct(i)/(nt(i)*exp(-0.5*m));
		
		// Numerical soln for baranov equation w/o the use of ADJoint code.
		// ft(i)   = get_f1(ct(i),m,nt(i));      

		// Numerical soln for Baranov equation with the use of ADJoint code.
		ft(i)   = get_f(ct(i),m,nt(i));      

		zt(i)   = m+ft(i);
		rt(i)   = a*nt(i)/(1.+b*nt(i));
		nt(i+1) = nt(i)*exp(-zt(i)) + rt(i);
	}
	epsilon = yt(1,n) - elem_prod(q*nt(1,n),exp(-0.5*zt(1,n)));

	f = 0.5*(n-1.)*log(norm2(epsilon));

FUNCTION dvariable get_f1(const double& ct, const prevariable& m, const prevariable& nt)
	{
		//use newtons root finding method to calc f.
		dvariable ft;
		ft=(ct/nt);
		dvariable ctmp;   // MUST use dvaribles to get the correct derivative info.
		dvariable df_ctmp;
		

		for(int iter=1; iter<=7; iter++)
		{
			dvariable t1 = (exp(-m-ft));		
			dvariable t2 = (m+ft);	
			ctmp=(nt*ft*(1.-t1)/t2);
			df_ctmp=(nt*(1.-t1)/t2 - nt*ft*(1.-t1)/(t2*t2) + nt*ft*t1/t2);
			ft -= ((ctmp-ct)/df_ctmp);
		}
		
		return(ft);
	}

FUNCTION simulateData
	int i;
	random_number_generator rng(999);
	no    = mfexp(log_no);
	m     = mfexp(log_m);
	q     = mfexp(log_q);
	reck  = 4.*h/(1.-h);
	a     = reck*(1.-mfexp(-m));
	b     = (reck-1.)/no;
	nt(1) = no;
	rt(1) = no*(1.-mfexp(-m));
	ft    = 0.15;

	for( i = 1; i <= n; i++ )
	{
		zt(i)   = m+ft(i);
		rt(i)   = a*nt(i)/(1.+b*nt(i));
		nt(i+1) = nt(i)*exp(-zt(i)) + rt(i);
	}
	ct(1,n) = value(elem_div(elem_prod(nt(1,n),elem_prod(ft,(1.-exp(-zt)))),zt));
	yt(1,n) = value(elem_prod(q*nt(1,n),exp(-0.5*zt(1,n))));

	// Add observation errors
	double sigma = 1.e-3;
	dvector obsError(1,n);
	obsError.fill_randn(rng);
	yt      = elem_prod(yt,exp(sigma*obsError-0.5*sigma*sigma));

REPORT_SECTION
	REPORT(no);
	REPORT(h);
	REPORT(m);
	REPORT(q);
	REPORT(ft);
	REPORT(nt);

TOP_OF_MAIN_SECTION
	time(&start);
	arrmblsize = 50000000;
	gradient_structure::set_GRADSTACK_BUFFER_SIZE(1.e7);
	gradient_structure::set_CMPDIF_BUFFER_SIZE(1.e7);
	gradient_structure::set_MAX_NVAR_OFFSET(5000);
	gradient_structure::set_NUM_DEPENDENT_VARIABLES(5000);
 

GLOBALS_SECTION
	/**
	\def REPORT(object)
	Prints name and value of \a object on ADMB report %ofstream file.
	*/
	#undef REPORT
	#define REPORT(object) report << #object "\n" << object << endl;

	#undef COUT
	#define COUT(object) cout<<fixed<<#object "\n"<<object<<endl;

	#include <iostream>
	#include <iomanip>
	using namespace std;



	#include <admodel.h>
	#include <time.h>
	#include <statsLib.h>
	time_t start,finish;
	long hour,minute,second;
	double elapsed_time;

	/*
	ADJoint code for solving the Baranov Catch equation.
	*/
	void deriv_f(void);
	
	dvariable get_f(const double& ct, const prevariable& m, const prevariable& nt)
	{
		//use newtons root finding method to calc f.
		dvariable ft;
		ft=value(ct/nt);
		double ctmp;
		double df_ctmp;
		
		for(int iter=1; iter<=17; iter++)
		{
			double t1 = value(exp(-m-ft));
			double t2 = value(m+ft);
			ctmp=value(nt*ft*(1.-t1)/t2);
			df_ctmp=value(nt*(1.-t1)/t2 - nt*ft*(1.-t1)/(t2*t2) + nt*ft*t1/t2);
			ft -= ((ctmp-ct)/df_ctmp);
			// cout<<iter<<"\t"<<ctmp-ct<<endl;
			if(fabs(ctmp-ct)<=1.e-14) break;
			
		}


		// Push variables on stack
		save_identifier_string("place1");
		nt.save_prevariable_value();
		nt.save_prevariable_position();
		m.save_prevariable_value();
		m.save_prevariable_position();
		save_identifier_string("place2");
		ft.save_prevariable_value();
		ft.save_prevariable_position();


		//Call adjoint code to get derivative
		ADJOINT_CODE(deriv_f);
		return(ft);
	}


	void deriv_f(void)
	{
		//POP variables off stack in reverse order
		prevariable_position ft_pos = restore_prevariable_position();
		double ad_ft=restore_prevariable_value();
		verify_identifier_string("place2");
		prevariable_position m_pos = restore_prevariable_position();
		double ad_m = restore_prevariable_value();
		prevariable_position nt_pos = restore_prevariable_position();
		double ad_nt = restore_prevariable_value();
		verify_identifier_string("place1");
		double dft=restore_prevariable_derivative(ft_pos);
		//cout<<"dft\t"<<dft<<endl;
		
		
		//derivatives from implicit differentiation.
		double dfb;
		double t1 = (-ad_m - ad_ft);
		double t2 = exp(t1);
		double t8 = (ad_ft * ad_ft);
		dfb = (-ad_ft * (-0.1e1 + t2) * t1 / ad_nt / ((-ad_m + ad_ft * ad_m + t8) * t2 + ad_m))*dft;
		//cout<<"dfb\t"<<dfb<<endl;

		double dfm;
		double t3 = exp(t1);
		//t8 = F * F;
		dfm = (-ad_ft * (-0.1e1 + (ad_m + ad_ft + 0.1e1) * t3) / ((-ad_m + ad_ft * ad_m + t8) * t3 + ad_m))*dft;
		//cout<<"dfm\t"<<dfm<<endl;
		
		save_double_derivative(dfb,nt_pos);
		save_double_derivative(dfm,m_pos);
	}


	
FINAL_SECTION
	time(&finish);
	elapsed_time=difftime(finish,start);
	hour=long(elapsed_time)/3600;
	minute=long(elapsed_time)%3600/60;
	second=(long(elapsed_time)%3600)%60;
	cout<<endl<<endl<<"*******************************************"<<endl;
	cout<<"--Start time: "<<ctime(&start)<<endl;
	cout<<"--Finish time: "<<ctime(&finish)<<endl;
	cout<<"--Runtime: ";
	cout<<hour<<" hours, "<<minute<<" minutes, "<<second<<" seconds"<<endl;
	cout<<"*******************************************"<<endl;

