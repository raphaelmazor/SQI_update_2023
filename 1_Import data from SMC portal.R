#Step 1: Import data from SMC data portal


library(DBI) # needed to connect to data.dfbase
library(dbplyr) # needed to connect to data.dfbase
library(RPostgreSQL) # needed to connect to our data.dfbase
library(rstudioapi) # just so we can type the password as we run the script, so it is not written in the clear
library(tidyverse)
library(lubridate)

########
#Create the connection
con <- dbConnect(
  PostgreSQL(),
  host = "geobiology.cottkh4djef2.us-west-2.rds.amazonaws.com",
  dbname = 'smc',
  user='smcread',
  password='1969$Harbor'
)

#Stations data
lustations_df<-dbGetQuery(con, sql(
  "SELECT *
FROM
sde.lu_stations"
)) %>% as_tibble()

chansum_df<-dbGetQuery(con, sql(
  "SELECT *
FROM
sde.unified_channelengineering_summary"
)) %>% as_tibble()


#Biological data: CSCI and ASCI
csci_df<-dbGetQuery(con, sql(
  "SELECT *
FROM
sde.analysis_csci_core"
)) %>% as_tibble()

asci_df<-dbGetQuery(con, sql(
  "SELECT *
FROM
sde.analysis_asci"
)) %>% as_tibble()

#Habitat data: PHAB
ipi_df<-dbGetQuery(con, sql(
  "SELECT *
FROM
sde.analysis_ipi"
)) %>% as_tibble()

#Might not need these two tables
# phab_met<-dbGetQuery(con, sql(
#   "SELECT *
# FROM
# sde.analysis_phabmetrics"
# )) %>% as_tibble()
# phab_met_df<-dbGetQuery(con, sql(
#   "SELECT *
# FROM
# sde.analysis_phab_ipi"
# )) %>% as_tibble()

#Habitat data: CRAM
cram_df<-dbGetQuery(con, sql(
  "SELECT *
FROM
sde.tblcramindexandattributescores"
)) %>% as_tibble()

#Water chemistry
nutrients_df<-dbGetQuery(con, sql(
  "SELECT *
FROM
sde.analysis_chem_nutrients_0"
)) %>% as_tibble()

cond_df<-dbGetQuery(con, sql(
  "SELECT *
FROM
sde.analysis_combined_specificconductivity"
)) %>% as_tibble()

chem_df<-dbGetQuery(con, sql(
  "SELECT *
FROM
sde.unified_chemistry"
)) %>% as_tibble()

#Export everything
write_csv(lustations_df, "NotForGit/Step1/lustations_df.csv")
write_csv(chansum_df, "NotForGit/Step1/chansum_df.csv")
write_csv(csci_df, "NotForGit/Step1/csci_df.csv")
write_csv(asci_df, "NotForGit/Step1/asci_df.csv")
write_csv(ipi_df, "NotForGit/Step1/ipi_df.csv")
write_csv(nutrients_df, "NotForGit/Step1/nutrients_df.csv")
write_csv(cond_df, "NotForGit/Step1/cond_df.csv")
write_csv(chem_df, "NotForGit/Step1/chem_df.csv")


