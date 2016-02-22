// the simple example modified to test cubic splines
// by Ian Taylor
// based on example code provided by Mark Payne 
// at http://groups.google.com/group/admb-users/browse_thread/thread/e6ba196af3478dc0/1952dcc0dfbb6241?#1952dcc0dfbb6241
// who in turn was aided by Derek Seiple
 

DATA_SECTION
  init_int nobs
  init_vector Y(1,nobs)
  init_vector X(1,nobs)

  init_int Nknots
  init_vector knotsX(1,Nknots)
  init_vector LO(1,Nknots)
  init_vector HI(1,Nknots)
  init_ivector PH(1,Nknots)
  init_vector parm(1,2)

  // counter for MCMC
  int mccounter
  !! mccounter = 1;

  // counter
  int i

PARAMETER_SECTION

  //init_bounded_vector knotsY(1,Nknots)
  init_bounded_number_vector knotsY(1,Nknots,LO,HI,PH)

  vector pred_Y(1,nobs)
  objective_function_value obj_fun

  // You must declare at least one object of type sdreport to do the mcmc calculations
  sdreport_number Number1 

  number val
  vector values(1,101)
  vector interpolated(1,101)

PROCEDURE_SECTION

  // define splines
  dvector splineX(1,Nknots);
//  dvar_vector splineY(1,Nknots);
  dvar_vector splineY(1,Nknots);

  //... Populate splineX and splineY ...//
  splineX = knotsX;

  splineY = knotsY;

  //Create the class
  vcubic_spline_function splinefn=vcubic_spline_function(splineX,splineY,parm(1),parm(2));


  //Evaluate the function
  val = 0;
  for(i=1; i<=101; i++){
    values(i) = val;
    val = val + 0.1;
  }
  interpolated = splinefn(values); 

  for(i=1; i<=nobs; i++) pred_Y(i) = splinefn(X(i));

  obj_fun=(norm2(pred_Y-Y)); 
  obj_fun=nobs/2.*log(obj_fun);    // make it a likelihood function so that
                                   // covariance matrix is correct

  if (mceval_phase() )
  {
    if(mccounter%20==0) cout<<"mccounter = "<<mccounter<<endl;

    // delete any old mcmc output files
    // may have to comment this out if -mcr is supposed to add to file
    if (mccounter==1)  remove( "posteriors.rep" ); 

    // define the mcmc output file
    ofstream posts("posteriors.rep", ios::out | ios::app);

    // add a header
    if (mccounter==1) posts<<"counter  obj_fun  pred_Y  interpolated"<< endl;
    // fill in values
    posts<<mccounter<<"  "<<obj_fun<<"  "<<pred_Y<<"  "<<interpolated<<endl;
    mccounter++;
  };

REPORT_SECTION
  report<<"#obj_fun"<<endl<<obj_fun<<endl<<endl;
  report<<"#nobs"<<endl<<nobs<<endl<<endl;
  report<<"#Nknots"<<endl<<Nknots<<endl<<endl;
  report<<"#splineX  splineY  derivative"<<endl;
  for(i=1; i<=Nknots; i++){ 
    report<<knotsX(i)<<"  "<<knotsY(i)<<"  ";
    if(i==1) report<<parm(1)<<endl;
    if(i==Nknots) report<<parm(2)<<endl;
    if(i!=1 & i!=Nknots) report<<"NA"<<endl;
  }
  report<<endl<<"#X  Y  pred_Y"<<endl;
  for(i=1; i<=nobs; i++) report<<X(i)<<"  "<<Y(i)<<"  "<<pred_Y(i)<<endl;
  report<<endl<<"#values  interpolated"<<endl;
  for(i=1; i<=101; i++) report<<values(i)<<"  "<<interpolated(i)<<endl;

