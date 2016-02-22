DATA_SECTION

  init_int n
  init_int m


  init_ivector csize(1,m);
 !! ivector csize1=csize+1;

  init_imatrix cons(1,m,1,csize1);  // first column is the constrained row
                              // rest is the constraining rows.
 !! int n1=n*(n-1)/2;
  init_vector x(1,n1);

  matrix M(1,n,1,n);
  matrix N(1,n,1,n);

 LOC_CALCS
  
  int i,j;
  imatrix cons1(1,m);
  ivector cons2(1,m);

  for (i=1;i<=m;i++)
  {
    cons1(i)=cons(i)(2,cons(i).indexmax()).shift(1);
  }
  cons2=column(cons,1);

  M.initialize();
  
  int ii=0;
  M(1,1)=1.0;
  for (int i=2;i<=n;i++)
  {
    M(i,i)=1.0;
    M(i)(1,i-1)=x(ii+1,ii+i-1).shift(1);
    ii+=i-1;
    M(i)/=norm(1.e-20+M(i));
  }

  cout << cons1 << endl;
  N=M;
  for (int i=1;i<=m;i++)
  {
    int mmin=cons1(i).indexmin();
    int mmax=cons1(i).indexmax();
    dmatrix Y(mmin,mmax,1,n);
    for (int j=mmin;j<=mmax;j++)
    {
      Y(j)=M(cons1(i,j));
    }

    for (int j=1;j<=mmax;j++)
    {
      Y(j)/=norm(1.e-20+Y(j));
      for (int k=j+1;k<=mmax;k++)
      {
        Y(k)-=(Y(k)*Y(j))*Y(j);
      }
    }
    dvector tmp(1,n);
    tmp=M(cons2(i));
    for (int j=1;j<=mmax;j++)
    {
      tmp-=(tmp*Y(j))*Y(j);
    }
    N(cons2(i))=tmp/norm(tmp);
  }

  cout << "Choleski " << endl;
  cout << setfixed() << setprecision(3) << setw(6) << N << endl;

  dmatrix C=N*trans(N);
  cout << endl << "Correlation matrix satisfies constraints" << endl;
  cout << setfixed() << setprecision(3) << setw(6) << C << endl;

  dmatrix Cinv=inv(C);
  dvector v(1,n);
  for (i=1;i<=n;i++)
    v(i)=sqrt(Cinv(i,i));

  for (i=1;i<=n;i++)
    for (j=1;j<=n;j++)
      Cinv(i,j)/=(v(i)*v(j));
  cout << endl << "Inverse Correlation matrix satifies constraints" << endl;
  cout << setfixed() << setprecision(3) << setw(6) << inv(Cinv)  << endl;

PARAMETER_SECTION
  objective_function_value f

PROCEDURE_SECTION
