[PARAM] @annotated
CL  : 0.345 : Clearance (L/hr)
V   : 1.75  : Volume (L) 
wt  : 2.9   : Weight (kg)
pma : 34.8  : post-menstral age (wk)
scr : 0.9   : serum creatinine (mg/dL)
RDV : 0     : observed dv value (mg/L)
CID : 0     : Base ID
dose: 0     : dose (mg)


[CMT] @annotated
CENT : Central compartment (mg)

[PKMODEL]
ncmt=1, trans=11

[MAIN]
double idose = 0; 
if (EVID==1) idose = dose;
double NORM_WT = 2.9;
double NORM_PMA = 34.8;
double CLi = CL*pow(wt/NORM_WT,0.75)*(1/(1 + pow((pma/NORM_PMA),-4.53)))*pow(1/scr, 0.267)*exp(ECL);
double Vi = V*(wt/NORM_WT)*exp(EV);
  
[OMEGA] @annotated
ECL : 0.04 : Eta on CL
EV  : 0.01 : Eta on V

[SIGMA] @annotated
PROP : 0.02 : Proportional error

[TABLE]
double CP = CENT/Vi;
double DV = CP*(1+PROP);

[CAPTURE] @annotated
CP  : predicted plasma concentration (mg/L)
DV  : plasma concentration (mg/L)
CLi : Individual Clearance (L/hr)
Vi  : Individual Volume (L)
wt  :  Weight (kg)
pma : post-menstral age (wk)
scr : serum creatinine (mg/dL)
RDV : observed dv value (mg/L)
CID : Base ID
idose: idosing
