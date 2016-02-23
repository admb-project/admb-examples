#  Mark-Recapture random effects model

Filed under:  [Random effect][1], [Ecology][2], [Mark-recapture][3]

**Mark-Recapture random effects model**  
From: [Mark N. Maunder][4], [Hans J. Skaug][5], David A. Fournier and Simon D. Hoyle. (2009) Comparison of fixed effect, random effect, and hierarchical Bayes estimators for mark recapture data using AD Model builder.  
  
The model is compiled using the command line option –re  
  
admb –re name  
  
For the penguins and albatross applications, an additional command line option is needed when the model is run to ensure there is enough memory -mno 2000  
  
name -mno 2000  
  
***.tpl file**

  
DATA_SECTION  
init_int NRCperiods  
init_vector Releases(1,NRCperiods)  
ivector temp(1,NRCperiods)  
!!temp.fill_seqadd(1,1);  
init_matrix data(1,NRCperiods,temp,NRCperiods)  
  
PARAMETER_SECTION  
init_number meanS(1)  
init_number ln_sdS(2)  
init_number meanp(1)  
init_number ln_sdp(2)  
  
random_effects_vector Sdev(1,NRCperiods,2)  
random_effects_vector pdev(1,NRCperiods,2)  
  
number sdS  
number sdp  
vector S(1,NRCperiods)  
vector p(1,NRCperiods)  
  
matrix Scum(1,NRCperiods,1,NRCperiods)  
matrix Pcum(1,NRCperiods,1,NRCperiods)  
  
objective_function_value f  
  
PROCEDURE_SECTION  
sdS=mfexp(ln_sdS);  
sdp=mfexp(ln_sdp);  
S=elem_div(mfexp(meanS Sdev*sdS),  
(1 mfexp(meanS Sdev*sdS)));  
p=elem_div(mfexp(meanp pdev*sdp),  
(1 mfexp(meanp pdev*sdp)));  
for (int i=1;i<=NRCperiods;i )  
{  
Scum(i,i)=S(i);  
Pcum(i,i)=1;  
for (int j=i 1;j<=NRCperiods;j )  
{  
Scum(i,j)=Scum(i,j-1)*S(j);  
Pcum(i,j)=Pcum(i,j-1)*(1.0-p(j-1));  
}  
  
Pcum(i)=elem_prod(Pcum(i),p);  
  
for (j=i;j<=NRCperiods;j ) f =-data(i,j)*log(Scum(i,j)*Pcum(i,j));  
  
f =-(Releases(i)-sum(data(i)))*log(1-sum(elem_prod(Scum(i),Pcum(i))));  
}  
  
f =0.5*norm2(Sdev) 0.5*norm2(pdev);  
  
  
REPORT_SECTION  
report<<"S "<<S<<endl;  
report<<"p "<<p<<endl;  
  
**European dipper *.dat file **  
  

    #  init_int NRCperiods
    6
    #init_vector Releases(1,NRCperiods)
    22 60 78 80 88 98
    #init_matrix data(1,NRCperiods,temp,NRCperiods)
    11 2 0 0 0 0
      24 1 0 0 0
        34 2 0 0
          45 1 2
            51 0
              52

  
  
**European dipper *.pin file**  
  

    #  init_number meanS(1)
    1
    #  init_number ln_sdS(2)
    0
    #  init_number meanp(1)
    1
    #  init_number ln_sdp(2)
    0
    #  init_vector Sdev(1,NRCperiods,1)
    0 0 0 0 0 0 0
    #  init_vector pdev(1,NRCperiods,1)
    0 0 0 0 0 0 0

  
  
**Yellow-eyed penguin *.dat file **  
(You will have to mofify the pin file appropriately)  
  

    #  init_int NRCperiods
    20
    #init_vector Releases(1,NRCperiods)
    12 12 10 14 17 21 9 30 25 41 45 79 97 80 62 80 74 74 46 45
    #init_matrix data(1,NRCperiods,temp,NRCperiods)
    8 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
      7 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
        8 0 2 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
         13 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
           14 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0
              6 4 1 0 0 0 0 0 0 0 0 0 0 0 0
                6 1 1 0 1 0 0 0 0 0 0 0 0 0
                 21 5 1 0 0 0 0 0 0 0 0 0 0
                   22 0 1 0 0 0 0 0 0 0 0 0
                     35 3 0 0 0 0 0 0 0 0 0
                       43 0 0 0 0 0 0 0 0 0
                         65 2 1 0 0 0 0 0 0
                           66 2 1 0 2 0 0 0
                            48 13 1 0 0 0 0
                               44 4 1 0 0 0
                                 61 3 0 1 0
                                   55 4 1 0
                                     36 7 2
                                       30 4
                                         31

  
  
**Albatross *.dat file **  
(You will have to mofify the pin file appropriately)  
  

    #  init_int NRCperiods
    12
    #init_vector Releases(1,NRCperiods)
    11 12 13 101 101 136 469 606 707 798 938 1106
    #init_matrix data(1,NRCperiods,temp,NRCperiods)
    5 1 1 0 0 0 0 0 0 0 0 0
     10 0 0 0 0 0 0 0 0 0 0
        4 2 1 1 0 0 0 0 0 0
        64 30 5 1 0 0 0 0 0
          81 11 8 0 1 0 0 0
            94 26 2 3 1 0 0
            350 49 13 2 1 0
              477 52 15 2 2
                496 84 21 3
                  583 95 24
                    691 127
                        741

****

**References**

 

Mark N. Maunder, Hans J. Skaug, David A. Fournier, and Simon D. Hoyle (2009). Comparison of Fixed Effect, Random Effect,and Hierarchical Bayes Estimators for Mark Recapture Data Using AD Model Builder. In  D.L. Thomson et al. (eds.), _Modeling Demographic Processes in Marked Populations_, Environmental and Ecological Statistics 3, DOI 10.1007/978-0-387-78151-8 42,

 

 

 

[1]: http://www.admb-project.org/@@search?Subject:list=Random effect
[2]: http://www.admb-project.org/@@search?Subject:list=Ecology
[3]: http://www.admb-project.org/@@search?Subject:list=Mark-recapture
[4]: http://www.iattc.org/iattc-staffMMaunder.htm
[5]: http://www.uib.no/People/hsk021/
