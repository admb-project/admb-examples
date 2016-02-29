Mark-Recapture random effects model
From: [Mark N. Maunder][1], [Hans J. Skaug][2], David A. Fournier and Simon D. Hoyle. (2009) Comparison of fixed effect, random effect, and hierarchical Bayes estimators for mark recapture data using AD Model builder.

The model is compiled using the command line option –re

admb –re name

For the penguins and albatross applications, an additional command line option is needed when the model is run to ensure there is enough memory -mno 2000

name -mno 2000

<div class="wikitext"><br>DATA_SECTION<br>init_int NRCperiods<br>init_vector Releases(1,NRCperiods)<br>ivector temp(1,NRCperiods)<br>!!temp.fill_seqadd(1,1);<br>init_matrix data(1,NRCperiods,temp,NRCperiods)<br><br>PARAMETER_SECTION<br>init_number meanS(1)<br>init_number ln_sdS(2)<br>init_number meanp(1)<br>init_number ln_sdp(2)<br><br>random_effects_vector Sdev(1,NRCperiods,2)<br>random_effects_vector pdev(1,NRCperiods,2)<br><br>number sdS<br>number sdp<br>vector S(1,NRCperiods)<br>vector p(1,NRCperiods)<br><br>matrix Scum(1,NRCperiods,1,NRCperiods)<br>matrix Pcum(1,NRCperiods,1,NRCperiods)<br><br>objective_function_value f<br><br>PROCEDURE_SECTION<br>sdS=mfexp(ln_sdS);<br>sdp=mfexp(ln_sdp);<br>S=elem_div(mfexp(meanS+Sdev*sdS),<br>(1+mfexp(meanS+Sdev*sdS)));<br>p=elem_div(mfexp(meanp+pdev*sdp),<br>(1+mfexp(meanp+pdev*sdp)));<br>for (int i=1;i&lt;=NRCperiods;i++)<br>{<br>Scum(i,i)=S(i);<br>Pcum(i,i)=1;<br>for (int j=i+1;j&lt;=NRCperiods;j++)<br>{<br>Scum(i,j)=Scum(i,j-1)*S(j);<br>Pcum(i,j)=Pcum(i,j-1)*(1.0-p(j-1));<br>}<br><br>Pcum(i)=elem_prod(Pcum(i),p);<br><br>for (j=i;j&lt;=NRCperiods;j++) f+=-data(i,j)*log(Scum(i,j)*Pcum(i,j));<br><br>f+=-(Releases(i)-sum(data(i)))*log(1-sum(elem_prod(Scum(i),Pcum(i))));<br>}<br><br>f+=0.5*norm2(Sdev)+0.5*norm2(pdev);<br><br><br>REPORT_SECTION<br>report&lt;&lt;"S "&lt;&lt;S&lt;&lt;endl;<br>report&lt;&lt;"p "&lt;&lt;p&lt;&lt;endl;<br><br><strong>European dipper *.dat file </strong><br><br>
<pre>#  init_int NRCperiods
6
#init_vector Releases(1,NRCperiods)
22 60 78 80 88 98
#init_matrix data(1,NRCperiods,temp,NRCperiods)
11 2 0 0 0 0
  24 1 0 0 0
    34 2 0 0
      45 1 2
        51 0
          52</pre>
<br><br><strong>European dipper *.pin file</strong><br><br>
<pre>#  init_number meanS(1)
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
0 0 0 0 0 0 0</pre>
<br><br><strong>Yellow-eyed penguin *.dat file </strong><br>(You will have to mofify the pin file appropriately)<br><br>
<pre>#  init_int NRCperiods
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
                                     31</pre>
<br><br><strong>Albatross *.dat file </strong><br>(You will have to mofify the pin file appropriately)<br><br>
<pre>#  init_int NRCperiods
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
                    741</pre>
</div>

#References
Mark N. Maunder, Hans J. Skaug, David A. Fournier, and Simon D. Hoyle (2009). Comparison of Fixed Effect, Random Effect,and Hierarchical Bayes Estimators for Mark Recapture Data Using AD Model Builder. In  D.L. Thomson et al. (eds.), Modeling Demographic Processes in Marked Populations, Environmental and Ecological Statistics 3, DOI 10.1007/978-0-387-78151-8 42,

[1] http://www.iattc.org/iattc-staffMMaunder.htm
[2]: http://folk.uib.no/hsk021/
