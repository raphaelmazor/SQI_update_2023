# Modeling
# Data prep
library(tidyverse)
library(tidymodels)

#Data prep
#Classify sites based on biological condition, using CSCI and ASCI_D, 10th percentiles (CSCI: 0.79; ASCI_D: 0.86)
# Impacted for CSCI and ASCI
# Impacted for ASCI
# Healthy
# Impacted for CSCI



#Use initial_split in tidy models to split the data 80/20 into model training and model testing data subsets

#Chem model
#Create a model (glm) to predict the likelihood of impacted biology (any index) given TN, TP, and SpCond

#Habitat model
#Create a model (glm) to predict the likelihood of impacted biology (any index) given overall CRAM and overall IPI
#Explore alternatives based on CRAM attributes (ps, hy, bs, blc) and *scored* phab metrics (Ev_FlowHab_score,  H_AqHab_score,  H_SubNat_score, PCT_SAFN_score, XCMG_score)
#Select the best based on AIC, or overall accuracy. 

#The best combo must include at least ONE phab indicator and ONE CRAM indicator.
#If you're using CRAM attributes, it cannot be blc alone. In fact, better to avoid blc entirely, if possible.


#Export the best two models into "NotForGit/Step3"