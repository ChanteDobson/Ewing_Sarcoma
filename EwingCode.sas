/* Generated Code (IMPORT) */
/* Source File: EwingData.csv */
/* Source Path: /home/u62583702/Ewing */
/* Code generated on: 1/9/23, 7:39 PM */

%web_drop_table(WORK.IMPORT);


FILENAME REFFILE '/home/u62583702/Ewing/EwingData.csv';

PROC IMPORT DATAFILE=REFFILE
	DBMS=CSV
	OUT=WORK.IMPORT;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.IMPORT; RUN;


%web_open_table(WORK.IMPORT);

data Ewingfree;
set Ewing;
if efstatuscat=0 and statuscat=1 then DisFreeCat=2;
else if efstatuscat=0 and statuscat=0 then DisFreeCat=0;
else if efstatuscat=1 and statuscat=0 then DisFreeCat=1;
else if efstatuscat=2 and statuscat=0 then DisFreeCat=1;
else if efstatuscat=1 and statuscat=1 then DisFreeCat=1;
else if efstatuscat=2 and statuscat=1 then DisFreeCat=1;
run;



Proc lifetest data= Ewingfree plots=survival(atrisk=0 to 2500 by 500);
Time OS_MONTHS*DisFreeCat(1);
Strata TissueStatusCat/test=logrank adjust=sidak;
Run;

Proc lifetest data= Ewingfree notable plots=none;
Time OS_MONTHS*DisFreeCat(1);
Strata TissueStatusCat/test=logrank adjust=bon;
Run;



Proc lifetest data= Ewingfree plots=survival(atrisk=0 to 2500 by 500);
Time OS_MONTHS*DisFreeCat(1);
Strata AgeCat/test=logrank adjust=sidak;
Run;

Proc lifetest data= Ewingfree notable plots=none;
Time OS_MONTHS*DisFreeCat(1);
Strata AgeCat/test=logrank adjust=bon;
Run;



Proc lifetest data= Ewingfree plots=survival(atrisk=0 to 2500 by 500);
Time OS_MONTHS*DisFreeCat(1);
Strata SexStatusCat/test=logrank adjust=sidak;
Run;

Proc lifetest data= Ewingfree notable plots=none;
Time OS_MONTHS*DisFreeCat(1);
Strata SexStatusCat/test=logrank adjust=bon;
Run;



proc phreg data=EwingFree;
class AgeCat (ref='1')/param=ref;
model OS_MONTHS*DisFreeCat(0)=AgeCat/rl;
assess ph;
run;



proc phreg data=EwingFree;
class AgeCat (ref='1')/param=ref;
model OS_MONTHS*StatusCat(0)=AgeCat TissueStatusCat SexStatusCat Age_t/risklimit;
Age_t=AgeCat*StatusCat;
assess ph;
run;

proc phreg data=EwingFree;
class AgeCat (ref='1')/param=ref;
model OS_MONTHS*StatusCat(0)=AgeCat TissueStatusCat SexStatusCat Age_Tissue Age_Sex/risklimit;
Age_Tissue=AgeCat*TissueStatusCat;
Age_Sex=AgeCat*SexStatusCat;
assess ph;
run;



proc logistic data=ewingfree;
class agecat (ref="1") Tissuestatuscat (ref="1") Sexstatuscat (ref="1")/param=ref;
model DisFreeCat (event="0") = agecat Tissuestatuscat Sexstatuscat agecat*Tissuestatuscat agecat*sexstatuscat;
oddsratio agecat;
run;



proc logistic data=ewingfree;
class agecat (ref="1") Tissuestatuscat (ref="1") Sexstatuscat (ref="1")/param=ref;
model DisFreeCat (event="0") = agecat Tissuestatuscat Sexstatuscat;
oddsratio agecat;
run;



proc freq data=ewingfree;
table DisFreeCat*AgeCat/chisq;
run;



proc freq data=ewingfree;
table DisFreeCat*AgeCat/chisq exact;
run;


proc freq data=ewingfree order=data;
table DisFreeCat*AgeCat/nocol norow nopercent relrisk;
run;


proc freq data=ewingfree;
table StatusCat*AgeCat/chisq;
run;



proc freq data=ewingfree order=data;
table StatusCat*AgeCat/nocol norow nopercent relrisk;
run;



proc freq data=ewingfree order=data;
table StatusCat*DisFreeCat/nocol norow nopercent relrisk;
run;



proc freq data=ewingfree order=data;
table StatusCat*DisFreeCat*agecat/nocol norow nopercent relrisk;
run;



