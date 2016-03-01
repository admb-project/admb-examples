#  Fisheries

Filed under:  [Fisheries][1]

Different uses of ADMB in fisheries stock assessments or other fisheries work

[A fisheries model with random effects][2]
:  Catch-age model from Schnute and Richards (1995) with annual recruitments as random effects.

[Baranov catch equation][3]
:  Example by Steven Martell of writing adjoint code in ADMB to numerically solve the Baranov catch equation. A simple simulation model is used to generate simulated catch and relative abundance data with observation error only. The assessment model is then conditioned on the simulated catch data.

[Pella-Tomlinson basic model][4]
:  Pella-Tomlinson by Arni Magnusson with user interface and formatted MCMC output. Repeats and extends the analysis of Polacheck et al. (1993).

[Pella-Tomlinson from ADMB manual][5]
:  Pella-Tomlinson example by Dave Fournier from the ADMB manual. Demonstrates several innovative modelling approaches: 6 month time step, time-varying K and q.

[1]: ./
[2]: http://otter-rsch.com/admbre/examples/caest/caest.html
[3]: ./../admb-tricks/adjoint-code-1/baranov-catch-equation.md
[4]: ./pella/
[5]: ./pella-t/
