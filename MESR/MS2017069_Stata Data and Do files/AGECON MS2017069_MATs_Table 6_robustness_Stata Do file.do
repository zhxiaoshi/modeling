**Adoption and welfare impacts of multiple agricultural technologies: Evidence from eastern Zambia
**********Makaiko G. Khonje, Julius Manda, Petros Mkandawire, Adane Hirpa Tufa and Arega D. Alene***********

******* Table 6: Robustness check on welfare effects of adopting MATs using panel regressions
global x hhsize agehh genderhh creditdummy ttownland rnonoxwnasetcap
global iv x_NGO x_gvmt d_mkt d_cooptv gp_member
xtivreg mz_yield $x (mats_cap = $iv ), fe vce (robust)
xtivreg mz_yield $x (mats_imv = $iv ), fe vce (robust)
xtivreg mz_yield $x (mats_imvcap = $iv ), fe vce (robust)
xtivreg mz_incttr $x (mats_cap = $iv ), fe vce (robust)
xtivreg mz_incttr $x (mats_imv = $iv ), fe vce (robust)
xtivreg mz_incttr $x (mats_imvcap = $iv ), fe vce (robust)
xtivreg rthi_c $x (mats_cap = $iv ), fe vce (robust)
xtivreg rthi_c $x (mats_imv = $iv ), fe vce (robust)
xtivreg rthi_c $x (mats_imvcap = $iv ), fe vce (robust)
***** Control function
global ffe hhsize agehh genderhh creditdummy ttownland rnonoxwnasetcap
xtlogit mats_cap x_NGO x_gvmt d_mkt d_cooptv  $ffe, fe
predict e,
rename e ecap
xtlogit mats_imv x_NGO x_gvmt d_mkt d_cooptv  $ffe, fe
predict e,
rename e eimv
xtlogit mats_imvcap x_NGO x_gvmt d_mkt d_cooptv  $ffe, fe
predict e,
rename e eimvcap
xtreg phci_in mats_cap ecap hhsize agehh genderhh creditdummy ttownland, fe vce (robust)
xtreg phci_in mats_imv eimv hhsize agehh genderhh creditdummy ttownland, fe vce (robust)
xtreg phci_in mats_imvcap eimvcap  hhsize agehh genderhh creditdummy ttownland, fe vce (robust)
drop ecap eimv eimvcap
********
