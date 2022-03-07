pacman::p_load(Epi)
data("steno2")
data("st2clin")
data("st2alb")
str(steno2)
steno2 <- data.table(steno2)
st2clin <- data.table(st2clin) ## long format
st2alb <- data.table(st2alb) ## long format

## curate
steno2[, age := as.numeric(difftime(as.Date(doBase), as.Date(doBth), unit="weeks"))/52.25]
steno2[, age := signif(age, digits = 2)]

st2alb

steno2[st2alb, on = 'id']

## baseline
steno <- steno2[st2clin[, .(test_date = min(doV), a1c, chol, crea), by = id], on = 'id']
dta <- steno[, .(allo, sex, age, a1c, chol, crea, baseCVD)]
tbl <- dta[,.(age_mean=mean(age), age_sd=sd(age), crea_mean=mean(crea, na.rm = TRUE), crea_sd=sd(crea, na.rm = TRUE)),.(allo)]
tbl[]
tbl[, crea_mean := signif(crea_mean, digits = 3)]
tbl[, crea_sd := signif(crea_sd, digits = 3)]
tbl[, age_mean := signif(age_mean, digits = 2)]
tbl[, age_sd := signif(age_sd, digits = 2)]



signif(tbl[ , .SD, .SDcols = is.numeric], digits = 2)


## metadata
## Data is from Epi package

## Steno-2 was a clinical trial conducted at Steno Diabetes Center 1993-2001. The intervention was intensified treatment versus conventional treatment of diabetes patients with micro-albuminuria.  The datsets here concern the extended follow-up of the trial population till 2015. Three files are provided: steno2 with one record per person, st2clin with one record per clinical visit and st2alb with one record per transition between states of albuminuria.  These dataset are entirely simulated, but designed to give approximately the same results as the original.

## steno2 is a data frame with 160 observations on the following 14 variables:
## id person id, numeric
## allo Original trial allocation, a factor with levels Int Conv
## sex Sex, a factor with levels F M
## baseCVD 0/1 indicator of preexisting CVD at baseline
## deathCVD 0/1 indicator whether cause of death was CVD
## doBth Date of birth, a Date
## doDM Date of diabetes diagnosis, a Date
## doBase Date of entry to study, a Date
## doCVD1 Date of 1st CVD event, a Date
## doCVD2 Date of 2nd CVD event, a Date
## doCVD3 Date of 3rd CVD event, a Date
## doESRD Date of end stage renal disease, a Date
## doEnd Date of exit from follow-up, a Date
## doDth Date of death, a Date
## st2clin is data frame with 750 observations on clinical measurements at different clinical visits:
## id person id, numeric
## doV Date of clinical visit, a Date
## a1c Glycosylated hemoglobin, mmol/mol
## chol Total cholesterol, mg/mol
## crea Creatinine, mg/mol
## st2alb is data frame with 307 observations of changes in complication (albuminuria) state
## id person id, numeric
## doTr Date of transition, a Date
## state State of albuminuria, factor with levels Norm, Mic, Mac. All persons begin in the state Micro-
## albuminuria.
