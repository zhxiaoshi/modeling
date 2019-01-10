
**Adoption and welfare impacts of multiple agricultural technologies: Evidence from eastern Zambia
**********Makaiko G. Khonje, Julius Manda, Petros Mkandawire, Adane Hirpa Tufa and Arega D. Alene***********

*********Table 1: Adoption combinations of multiple agricultural technologies

tab IMVCA panel_yr, row
tab IMVCA panel_yr, column

*DESCRIPTIVE STATISTICS
global Alist mz_yield mz_incttr rthi_c rnonoxwnasetcap phci imv ca_3ps hhsize genderhh agehh eduhh groupmembership ttownland accessofffarm contactNGOxagent contactgxtnagent mktinfodummy creditdummy informtechnlgy plot_dist good_soil medium_soil flat moderate_flat shallow moderare_deep d_coptv d_mmkt d_ftzd d_sdd fert_use herbcide_use manure_use rainfall_index

**********Table 2: Descriptive statistics by survey year 

tabstat $Alist, by (panel_yr ) stat (mean sd )

**********Table A2: Descriptive statistics by survey and adoption status 

global Blist mz_yield mz_incttr rthi_c rnonoxwnasetcap phci hhsize genderhh agehh eduhh groupmembership ttownland accessofffarm contactNGOxagent contactgxtnagent mktinfodummy creditdummy informtechnlgy plot_dist good_soil medium_soil flat moderate_flat d_coptv d_mmkt fert_use herbcide_use manure_use rainfall_index
tabstat $Blist if panel_yr==2012, by (IMVCA ) stat (mean )
tabstat $Blist if panel_yr==2015, by (IMVCA ) stat (mean )
ttest mz_yield if IMVCA==1|IMVCA==0 & panel_yr==2015, by (IMVCA )
...................
***** log transformation of selected variables
ge lnmz_yield= ln( mz_yield+1)
ge lnmz_yield0=lnmz_yield if IMVCA==0
ge lnmz_yield1=lnmz_yield if IMVCA==1
ge lnmz_yield2=lnmz_yield if IMVCA==2
ge lnmz_yield3=lnmz_yield if IMVCA==3
gen lnmz_incttr=ln( mz_incttr+1)
ge lnmz_incttr0=lnmz_incttr if IMVCA==0
ge lnmz_incttr1=lnmz_incttr if IMVCA==1
ge lnmz_incttr2=lnmz_incttr if IMVCA==2
ge lnmz_incttr3=lnmz_incttr if IMVCA==3
ge lnrthi_c= ln( rthi_c +1)
ge lnrthi0=lnrthi_c if IMVCA==0
ge lnrthi1=lnrthi_c if IMVCA==1
ge lnrthi2=lnrthi_c if IMVCA==2
ge lnrthi3=lnrthi_c if IMVCA==3
sort hhid 
local lnx agehh hhsize rnonoxwnasetcap d_mmkt d_coptv d_ftzd d_sdd d_aeo plot_dist  
local i=1
foreach var of varlist `lnx' {   
qui ge ln`var'=ln(`var')
local i=`i'+1 
}
* Mundlak fixed effect (generating time varying variables to be included in the estimation)
local _x hhsize agehh eduhh rnonoxwnasetcap ttownland accessofffarm groupmembership creditdummy contactgxtnagent contactNGOxagent mktinfodummy fert_use manure_use herbcide_use lnplot_dist good_soil medium_soil flat moderate_flat shallow moderare_deep rainfall_index d_coptv informtechnlgy d_mmkt
local i=1
foreach var of varlist `_x' {   
qui egen `var'_x=mean(`var'), by(DISTRICT BLOCK CAMP hhid)
local i=`i'+1 
}
*ECONOMETERIC ESTIMATIONS: MULTINOMIAL ENDOGENOUS SWITCHING REGRESSION MODEL (MESR)

*Multinomial Logit Selection (MNLS) Model with Mundlak Effect
global x lnhhsize genderhh eduhh lnagehh lnrnonoxwnasetcap ttownland accessofffarm  creditdummy  mktinfodummy fert_use manure_use herbcide_use lnplot_dist good_soil medium_soil flat moderate_flat shallow moderare_deep rainfall_index
global iv d_coptv informtechnlgy d_mmkt groupmembership contactgxtnagent contactNGOxagent
global loc katete lundazi
global xbar hhsize_x agehh_x rnonoxwnasetcap_x ttownland_x accessofffarm_x groupmembership_x creditdummy_x contactgxtnagent_x contactNGOxagent_x mktinfodummy_x fert_use_x herbcide_use_x shallow_x moderare_deep_x d_coptv_x informtechnlgy_x
*** Simple falsefication test
reg lnmz_yield $x $iv  if IMVCA==0
test d_coptv contactgxtnagent d_mmkt 
reg lnmz_yield $x $iv if IMVCA==1
test d_coptv informtechnlgy contactNGOxagent
reg lnmz_yield $x $iv if IMVCA==2 
test d_coptv informtechnlgy d_mmkt
reg lnmz_yield $x $iv if IMVCA==3
test d_mmkt contactNGOxagent groupmembership  
reg lnmz_incttr $x $iv  if IMVCA==0
test d_coptv contactgxtnagent d_mmkt 
reg lnmz_incttr $x $iv if IMVCA==1
test d_coptv informtechnlgy contactNGOxagent
reg lnmz_incttr $x $iv if IMVCA==2 
test d_coptv informtechnlgy d_mmkt
reg lnmz_incttr $x $iv if IMVCA==3
test d_mmkt contactNGOxagent groupmembership  
reg lnrthi_c $x $iv  if IMVCA==0
test d_coptv contactgxtnagent d_mmkt 
reg lnrthi_c $x $iv if IMVCA==1
test d_coptv informtechnlgy contactNGOxagent
reg lnrthi_c $x $iv if IMVCA==2 
test d_mmkt contactNGOxagent informtechnlgy  
reg lnrthi_c $x $iv if IMVCA==3
test d_mmkt contactgxtnagent informtechnlgy 

**********Table B1: Multinomial logit estimates of adoption of multiple agricultural technologies

mlogit IMVCA $x $iv $loc $xbar, base(0)

**********Table 3: Marginal effects for adoption of multiple agricultural technologies

margins, dydx ($x )

* Wald test
test $x $iv $loc $xbar
* Joint significance test
test $iv
test $loc
test $xbar

*Multinomial endogenous switching regression (MESR) framework
global z0 lnhhsize genderhh lnagehh lnrnonoxwnasetcap ttownland accessofffarm groupmembership creditdummy contactNGOxagent  informtechnlgy mktinfodummy fert_use herbcide_use good_soil medium_soil flat moderate_flat shallow moderare_deep rainfall_index
global zbar0 hhsize_x agehh_x rnonoxwnasetcap_x ttownland_x accessofffarm_x groupmembership_x creditdummy_x contactNGOxagent_x  mktinfodummy_x fert_use_x herbcide_use_x good_soil_x medium_soil_x flat_x moderate_flat_x shallow_x moderare_deep_x rainfall_index_x informtechnlgy_x
global z1 lnhhsize genderhh lnagehh lnrnonoxwnasetcap ttownland accessofffarm groupmembership creditdummy contactgxtnagent mktinfodummy fert_use herbcide_use good_soil medium_soil flat moderate_flat shallow moderare_deep rainfall_index
global zbar1 hhsize_x agehh_x rnonoxwnasetcap_x ttownland_x accessofffarm_x groupmembership_x creditdummy_x contactgxtnagent_x mktinfodummy_x fert_use_x herbcide_use_x shallow_x moderare_deep_x 
global z2 lnhhsize genderhh lnagehh lnrnonoxwnasetcap ttownland accessofffarm groupmembership creditdummy contactgxtnagent contactNGOxagent mktinfodummy fert_use herbcide_use good_soil medium_soil flat moderate_flat shallow moderare_deep rainfall_index
global zbar2 hhsize_x agehh_x rnonoxwnasetcap_x ttownland_x accessofffarm_x groupmembership_x creditdummy_x contactgxtnagent_x contactNGOxagent_x mktinfodummy_x fert_use_x herbcide_use_x shallow_x moderare_deep_x 
global z3 lnhhsize genderhh lnagehh lnrnonoxwnasetcap ttownland accessofffarm creditdummy contactgxtnagent mktinfodummy fert_use herbcide_use good_soil medium_soil flat moderate_flat shallow moderare_deep rainfall_index
global zbar3 hhsize_x agehh_x rnonoxwnasetcap_x ttownland_x accessofffarm_x creditdummy_x contactgxtnagent_x mktinfodummy_x fert_use_x herbcide_use_x shallow_x moderare_deep_x 

**** Install selmlog as a do file

**********Table B2A: Estimation of the mean equation for maize yield (second stage of MESR)

*** Impact of adoption on maize yield
selmlog lnmz_yield0 $z0 $zbar0, select(IMVCA=$x $iv $loc $xbar) boot(100) dmf(0) gen(m)
test $zbar0
*rename m0 _m0
rename m1 _m1
rename m2 _m2
rename m3 _m3
predict nmz0, xb
ge Emz00= exp( nmz0 )
ge Emz000= Emz00 if IMVCA  ==0
ge Emz001= Emz00 if IMVCA  ==1
ge Emz002= Emz00 if IMVCA  ==2
ge Emz003= Emz00 if IMVCA  ==3
selmlog lnmz_yield1 $z1 $zbar1, select(IMVCA=$x $iv $loc $xbar) boot(100) dmf(0) gen(m)
test $zbar1
rename m0 _m0
*rename m1 _m1
rename m2 _m2
rename m3 _m3
predict nmz1, xb
ge Emz10= exp( nmz1 )
ge Emz101= Emz10 if IMVCA  ==1
ge Emz13= Emz10 if IMVCA  ==3
ge Emz12= Emz10 if IMVCA  ==2
ge Emzu100= Emz10 if IMVCA  ==0
selmlog lnmz_yield2 $z2 $zbar2, select(IMVCA=$x $iv $loc $xbar) boot(100) dmf(0) gen(m)
test $zbar2
rename m0 _m0
rename m1 _m1
*rename m2 _m2
rename m3 _m3
predict nmz2, xb
ge Emz20= exp( nmz2 )
ge Emz202= Emz20 if IMVCA  ==2
ge Emz23= Emz20 if IMVCA  ==3
ge Emz21= Emz20 if IMVCA  ==1
ge Emzu200= Emz20 if IMVCA  ==0
selmlog lnmz_yield3 $z3 $zbar3, select(IMVCA=$x $iv $loc $xbar) boot(100) dmf(0) gen(m)
test $zbar3
rename m0 _m0
rename m1 _m1
rename m2 _m2
*rename m3 _m3
predict nmz3, xb
ge Emz30= exp( nmz3 )
ge Emz303= Emz30 if IMVCA  ==3
ge Emz32= Emz30 if IMVCA  ==2
ge Emz31= Emz30 if IMVCA  ==1
ge Emzu300= Emz30 if IMVCA  ==0

**********Table B2B: Estimation of the mean equation for maize income (second stage of MESR)

*** Impact of adoption on maize income
selmlog lnmz_incttr0 $z0 $zbar0, select(IMVCA=$x $iv $loc $xbar) boot(100) dmf(0) gen(m)
test $zbar0
*rename m0 _m0
rename m1 _m1
rename m2 _m2
rename m3 _m3
predict nmi0, xb
ge Emi00= exp( nmi0 )
ge Emi000= Emi00 if IMVCA  ==0
ge Emi001= Emi00 if IMVCA  ==1
ge Emi002= Emi00 if IMVCA  ==2
ge Emi003= Emi00 if IMVCA  ==3
selmlog lnmz_incttr1 $z1 $zbar1, select(IMVCA=$x $iv $loc $xbar) boot(100) dmf(0) gen(m)
test $zbar1
rename m0 _m0
*rename m1 _m1
rename m2 _m2
rename m3 _m3
predict nmi1, xb
ge Emi10= exp( nmi1 )
ge Emi101= Emi10 if IMVCA  ==1
ge Emi13= Emi10 if IMVCA  ==3
ge Emi12= Emi10 if IMVCA  ==2
ge Emiu100= Emi10 if IMVCA  ==0
selmlog lnmz_incttr2 $z2 $zbar2, select(IMVCA=$x $iv $loc $xbar) boot(100) dmf(0) gen(m)
test $zbar2
rename m0 _m0
rename m1 _m1
*rename m2 _m2
rename m3 _m3
predict nmi2, xb
ge Emi20= exp( nmi2 )
ge Emi202= Emi20 if IMVCA  ==2
ge Emi23= Emi20 if IMVCA  ==3
ge Emi21= Emi20 if IMVCA  ==1
ge Emiu200= Emi20 if IMVCA  ==0
selmlog lnmz_incttr3 $z3 $zbar3, select(IMVCA=$x $iv $loc $xbar) boot(100) dmf(0) gen(m)
test $zbar3
rename m0 _m0
rename m1 _m1
rename m2 _m2
*rename m3 _m3
predict nmi3, xb
ge Emi30= exp( nmi3 )
ge Emi303= Emi30 if IMVCA  ==3
ge Emi32= Emi30 if IMVCA  ==2
ge Emi31= Emi30 if IMVCA  ==1
ge Emiu300= Emi30 if IMVCA  ==0

*********Table B2C: Estimation of the mean equation for real household income (second stage of MESR)

*** Impact of adoption on household income
global p0 lnhhsize genderhh lnagehh lnrnonoxwnasetcap ttownland accessofffarm groupmembership creditdummy contactNGOxagent  informtechnlgy mktinfodummy fert_use herbcide_use good_soil medium_soil flat moderate_flat shallow moderare_deep rainfall_index
global pbar0 hhsize_x agehh_x rnonoxwnasetcap_x ttownland_x accessofffarm_x groupmembership_x creditdummy_x contactNGOxagent_x  mktinfodummy_x fert_use_x herbcide_use_x good_soil_x medium_soil_x flat_x moderate_flat_x shallow_x moderare_deep_x rainfall_index_x informtechnlgy_x
global p1 lnhhsize genderhh lnagehh lnrnonoxwnasetcap ttownland accessofffarm groupmembership creditdummy contactgxtnagent mktinfodummy fert_use herbcide_use good_soil medium_soil flat moderate_flat shallow moderare_deep rainfall_index
global pbar1 hhsize_x agehh_x rnonoxwnasetcap_x ttownland_x accessofffarm_x groupmembership_x creditdummy_x contactgxtnagent_x mktinfodummy_x fert_use_x herbcide_use_x shallow_x moderare_deep_x 
global p2 lnhhsize genderhh lnagehh lnrnonoxwnasetcap ttownland accessofffarm groupmembership creditdummy contactgxtnagent mktinfodummy fert_use herbcide_use good_soil medium_soil flat moderate_flat shallow moderare_deep rainfall_index
global pbar2 hhsize_x agehh_x rnonoxwnasetcap_x ttownland_x accessofffarm_x groupmembership_x creditdummy_x contactgxtnagent_x mktinfodummy_x fert_use_x herbcide_use_x shallow_x moderare_deep_x 
global p3 lnhhsize genderhh lnagehh lnrnonoxwnasetcap ttownland accessofffarm creditdummy contactgxtnagent mktinfodummy fert_use herbcide_use good_soil medium_soil flat moderate_flat shallow moderare_deep rainfall_index
global pbar3 hhsize_x agehh_x rnonoxwnasetcap_x ttownland_x accessofffarm_x creditdummy_x contactgxtnagent_x mktinfodummy_x fert_use_x herbcide_use_x shallow_x moderare_deep_x 
selmlog lnrthi0 $p0 $pbar0, select(IMVCA=$x $iv $loc $xbar) boot(100) dmf(0) gen(m)
test $pbar0
*rename m0 _m0
rename m1 _m1
rename m2 _m2
rename m3 _m3
predict rhi0, xb
ge rhi00= exp( rhi0 )
ge rhi000= rhi00 if IMVCA  ==0
ge rhi001= rhi00 if IMVCA  ==1
ge rhi002= rhi00 if IMVCA  ==2
ge rhi003= rhi00 if IMVCA  ==3
selmlog lnrthi1 $p1 $pbar1, select(IMVCA=$x $iv $loc $xbar) boot(100) dmf(0) gen(m)
test $pbar1
rename m0 _m0
*rename m1 _m1
rename m2 _m2
rename m3 _m3
predict rhi1, xb
ge rhi10= exp( rhi1 )
ge rhi101= rhi10 if IMVCA  ==1
ge rhi13= rhi10 if IMVCA  ==3
ge rhi12= rhi10 if IMVCA  ==2
ge rhiu100= rhi10 if IMVCA  ==0
selmlog lnrthi2 $p2 $pbar2, select(IMVCA=$x $iv $loc $xbar) boot(100) dmf(0) gen(m)
test $pbar2
rename m0 _m0
rename m1 _m1
*rename m2 _m2
rename m3 _m3
predict rhi2, xb
ge rhi20= exp( rhi2 )
ge rhi202= rhi20 if IMVCA  ==2
ge rhi23= rhi20 if IMVCA  ==3
ge rhi21= rhi20 if IMVCA  ==1
ge rhiu200= rhi20 if IMVCA  ==0
selmlog lnrthi3 $p3 $pbar3, select(IMVCA=$x $iv $loc $xbar) boot(100) dmf(0) gen(m)
test $pbar3
rename m0 _m0
rename m1 _m1
rename m2 _m2
*rename m3 _m3
predict rhi3, xb
ge rhi30= exp( rhi3 )
ge rhi303= rhi30 if IMVCA  ==3
ge rhi32= rhi30 if IMVCA  ==2
ge rhi31= rhi30 if IMVCA  ==1
ge rhiu300= rhi30 if IMVCA  ==0

**********Table 4: MESR based average effect of adoption of MATs on household welfare (ATT)

ttest Emz101 = Emz001
ttest Emz202 = Emz002
ttest Emz303 = Emz003
ttest Emi101 = Emi001
ttest Emi202 = Emi002
ttest Emi303 = Emi003
ttest rhi101 = rhi001
ttest rhi202 = rhi002
ttest rhi303 = rhi003

*******Table B3: MESR based average effect of adoption of MATs on household welfare: Unconditionla average effects

ttest Emz10 = Emz00
ttest Emz20 = Emz00
ttest Emz30 = Emz00
ttest Emi10 = Emi00
ttest Emi20 = Emi00
ttest Emi30 = Emi00
ttest rhi10 = rhi00
ttest rhi20 = rhi00
ttest rhi30 = rhi00

*******Table B4: MESR based average effect of adoption of MATs on household welfare: Heterogeneity effects 

ttest Emz31=Emz21
ttest Emz32=Emz12
ttest Emz23=Emz13
ttest Emi31=Emi21
ttest Emi32=Emi12
ttest Emi23=Emi13
ttest rhi31=rhi21
ttest rhi32=rhi12
ttest rhi23=rhi13

*ECONOMETERIC ESTIMATIONS: MULTINOMIAL ENDOGENOUS TREATMENT EFFECTS MODEL (METE)

*** Income based poverty
gen rthi_c_d= rthi_c/365
gen poor1= rthi_c_d< povline1
gen poorb= rthi_c_d< povlinebase
gen poor3= rthi_c_d< povline3

********
global r lnhhsize genderhh lnagehh lnrnonoxwnasetcap ttownland accessofffarm creditdummy contactgxtnagent mktinfodummy fert_use herbcide_use good_soil medium_soil flat moderate_flat shallow moderare_deep rainfall_index
global rbar hhsize_x agehh_x rnonoxwnasetcap_x ttownland_x accessofffarm_x creditdummy_x contactgxtnagent_x mktinfodummy_x fert_use_x herbcide_use_x shallow_x moderare_deep_x 
global ra lnhhsize genderhh lnagehh ttownland accessofffarm creditdummy contactgxtnagent mktinfodummy fert_use herbcide_use good_soil medium_soil flat moderate_flat shallow moderare_deep rainfall_index
global rabar hhsize_x agehh_x ttownland_x accessofffarm_x contactgxtnagent_x mktinfodummy_x fert_use_x herbcide_use_x shallow_x moderare_deep_x 

**********Table 5: Multinomial endogenous treatment effects model estimates of adoption impacts of MATs on poverty
mtreatreg poor1 $r $rbar, mtreat ( IMVCA = $x $iv $loc $xbar) base(0) sim(200) dens(normal) verbose difficult
mtreatreg poorb $r $rbar, mtreat ( IMVCA = $x $iv $loc $xbar) base(0) sim(200) dens(normal) verbose difficult
mtreatreg poor3 $r $rbar, mtreat ( IMVCA = $x $iv $loc $xbar) base(0) sim(200) dens(normal) verbose difficult

*********Table B5: PSM estimate effects of adoption of MATs on household welfare

*** Robustness check : Propensity score matching estimation
global x lnhhsize genderhh eduhh lnagehh lnrnonoxwnasetcap ttownland accessofffarm  creditdummy  mktinfodummy fert_use manure_use herbcide_use lnplot_dist good_soil medium_soil flat moderate_flat shallow moderare_deep rainfall_index
global iv d_coptv informtechnlgy d_mmkt groupmembership contactgxtnagent contactNGOxagent

* Generation of treatment variables
gen mv=1 if IMVCA==1
replace mv=0 if mv==.
gen caps=1 if IMVCA==2
replace caps=0 if caps==.
gen imvcaps=1 if IMVCA==3
replace imvcaps=0 if imvcaps==.
teffects psmatch ( lnmz_yield ) (mv $x $iv), atet
teffects psmatch ( lnmz_yield ) ( caps $x $iv ), atet
teffects psmatch ( lnmz_yield ) ( imvcaps $x $iv ), atet
teffects psmatch ( lnmz_incttr ) (mv $x ), atet
teffects psmatch ( lnmz_incttr ) ( caps $x ), atet
teffects psmatch ( lnmz_incttr ) ( imvcaps $x ), atet
teffects psmatch ( lnrthi_c ) (mv $x ), atet
teffects psmatch ( lnrthi_c ) ( caps $x ), atet
teffects psmatch ( lnrthi_c ) ( imvcaps $x ), atet

*******Table B6: MESR based average effect of adoption of MATs on household welfare (ATU) 
ttest Emzu100=Emz000
ttest Emzu200=Emz000
ttest Emzu300=Emz000
ttest Emiu100= Emi000
ttest Emiu200= Emi000
ttest Emiu300= Emi000
ttest rhiu100=rhi000
ttest rhiu200=rhi000
ttest rhiu300=rhi000


* FIGURES
* Graphs
egen p_mzyld=rowtotal (Emz000 Emz101 Emz202 Emz303)
egen p_rinc=rowtotal (rhi000 rhi101 rhi202 rhi303)
gen logmz_yield= log(p_mzyld-1)
gen logrthi_c= log(p_rinc-1)
* Figure 1
twoway kdensity logmz_yield if IMVCA ==0 || kdensity logmz_yield if IMVCA ==1||kdensity logmz_yield if IMVCA ==2||kdensity logmz_yield if IMVCA ==3
* Figure 2
twoway kdensity logrthi_c if IMVCA ==0 || kdensity logrthi_c if IMVCA ==1||kdensity logrthi_c if IMVCA ==2||kdensity logrthi_c if IMVCA ==3
drop lnmz_yield lnmz_yield0 lnmz_yield1 lnmz_yield2 lnmz_yield3 lnmz_incttr lnmz_incttr0 lnmz_incttr1 lnmz_incttr2 lnmz_incttr3 lnrthi_c lnrthi0 lnrthi1 lnrthi2 lnrthi3 lnagehh lnhhsize lnrnonoxwnasetcap lnd_mmkt lnd_coptv lnd_ftzd lnd_sdd lnd_aeo lnplot_dist hhsize_x agehh_x eduhh_x rnonoxwnasetcap_x ttownland_x accessofffarm_x groupmembership_x creditdummy_x contactgxtnagent_x contactNGOxagent_x mktinfodummy_x fert_use_x manure_use_x herbcide_use_x lnplot_dist_x good_soil_x medium_soil_x flat_x moderate_flat_x shallow_x moderare_deep_x rainfall_index_x d_coptv_x informtechnlgy_x d_mmkt_x nmz0 Emz00 Emz000 Emz001 Emz002 Emz003 nmz1 Emz10 Emz101 Emz13 Emz12 Emzu100 nmz2 Emz20 Emz202 Emz23 Emz21 Emzu200 nmz3 Emz30 Emz303 Emz32 Emz31 Emzu300 nmi0 Emi00 Emi000 Emi001 Emi002 Emi003 nmi1 Emi10 Emi101 Emi13 Emi12 Emiu100 nmi2 Emi20 Emi202 Emi23 Emi21 Emiu200 nmi3 Emi30 Emi303 Emi32 Emi31 Emiu300 rhi0 rhi00 rhi000 rhi001 rhi002 rhi003 rhi1 rhi10 rhi101 rhi13 rhi12 rhiu100 rhi2 rhi20 rhi202 rhi23 rhi21 rhiu200 _m0 _m1 _m2 rhi3 rhi30 rhi303 rhi32 rhi31 rhiu300 rthi_c_d poor1 poorb poor3 _TCA _Tcategory3 _TIMVCA p_mzyld p_rinc logmz_yield logrthi_c
**** THE END


