#Step 2: Create a flat file with all the data.

#We need the following columns

#Site

#First, consolidate lab and field reps.
#Lab reps: Pick rep #1
#Same-day field reps:
#-Take the HIGHEST CSCI score
#-Take the HIGHEST ASCI score
#-Take the AVERAGE of all other data (only applies to chem; no same-day replicates for habitat data)

#Once the data are aggregated into a single dataframe, export it into "NotForGit/Step2"


#Then, put into a wide-format table, with one row per site
#Make variable names confrom to those previously established by Marcus (as in sqi_old)
sqi_old<-read_csv("Data/sqi_data_old_version.csv")
sqi_updated<-read_csv("Data/sqi_data_updated_version.csv")

#The new table should have these columns BEFORE any modeling happens
sqi_old %>% names() %>% dput()
sqi_updated %>% names() %>% dput()
setdiff(sqi_old %>% names(), sqi_updated %>% names())
setdiff(sqi_updated %>% names(), sqi_old %>% names())

var_names_before_modeling<-
  c(
    ###Site data
    "MasterID", #from lustations
    "COMID", #from lustations
    "yr", #Derived from data aggregation. Maybe drop?
    "csci_sampledate", #Derived from data aggregation. Maybe drop?
    "Constraint_class", #Derived from SCAPE data.
    "SCAPE_q10", #Derived from SCAPE. Not in sqi_old. "lower" in sqi_updated
    "SCAPE_q50", #Derived from SCAPE. Not in sqi_old. "meds" in sqi_updated
    "SCAPE_q90", #Derived from SCAPE. Not in sqi_old. "upper" in sqi_updated
    "County", #Derived from lustation
    "SMC_region",#This is smc_shed in lustation
    "Regional_board",#Derived from lustation
    "Chan_type", #Derived from chansum_df. Not in sqi_old
    
    ###Model outputs
    # "pChem", #Model output
    # "pHab", #Model output
    # "pOverall", #Model output
    # "biological_condition", #Model output
    # "stress_condition", #Model output
    # "SQI", #Model output
    
    ###Biology data
    "ASCI", #From ASCI
    "CSCI", #From CSCI
    
    ###Habitat data: CRAM
    "blc", #CRAM buffer and landscape score
    "bs", #CRAM biotic score
    "ps", #CRAM physical structure score
    "hy", #CRAM hydrologic structure score
    
    ###Habitat data: PHAB
    #Note: Many of these are ambiguous or missing in sqi_old
    #All are derived from IPI data (other PHAB tables not needed)
    #Raw phab metrics
    "Ev_FlowHab", "H_AqHab", "H_SubNat","PCT_SAFN","PCT_RC", 
    "PCT_SAFNRC",#PCT_SAFN + PCT_RC. Not in sqi_old.
    
    #Index and metric scores
    "IPI", "Ev_FlowHab_score", "H_AqHab_score", "H_SubNat_score","PCT_SAFN_score",
    
    #Metric percentiles---???? Find out how this was generated? I think it's model output
    
    ###Water quality
    
    "Cond", #Conductivity in uS/cm, from chem data--either chem_df or cond_df
    "TN", #Total N in mg/L, from chem data--either chem_df or nutrients_df
    "TP" #Total P in mg/L, from chem data--either chem_df or nutrients_df
  )
    
    

    
#Alternatively, read and export sqi_dat
sqi_dat <- read_csv("NotForGit/Step1/sqi_dat.csv")
write_csv(sqi_dat, "NotForGit/Step2/sqi_dat_step2.csv")    
    
    
    
    
    
  