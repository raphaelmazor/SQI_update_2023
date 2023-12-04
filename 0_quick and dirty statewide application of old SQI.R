
sqi_dat<-dbGetQuery(con, sql(
  "SELECT t.masterid,
t.latitude,
t.longitude,
t.county,
t.huc,
t.smcshed,
t.smc_lu,
t.comid,
t.psa6c,
t.ref10,
t.qt10,
t.qt50,
t.qt90,
t.csci_sampledate,
t.csci_max,
t.year,
t.h_asci_max,
t.d_asci_max,
t.total_n_all,
t.total_n_rep_calc,
t.total_p_all,
t.total_p_rep_calc,
t.cond,
t.ipi,
t.ev_flowhab,
t.ev_flowhab_score,
t.h_aqhab,
t.h_aqhab_score,
t.h_aqhab_pred,
t.h_subnat,
t.h_subnat_score,
t.pct_safn,
t.pct_safn_score,
t.pct_safn_pred,
t.xcmg,
t.xcmg_score,
t.xcmg_pred,
t.pct_rc,
t.cram_score,
t.cram_bioticstructure,
t.cram_bufferandladscapecontext,
t.cram_hydrology,
t.cram_physicalstructure,
CASE
WHEN (((t.psa6c)::text = 'SN'::text) OR ((t.psa6c)::text = 'NC'::text)) THEN 'Wet'::text
ELSE 'Arid'::text
END AS psa2
FROM ( SELECT lu_stations.masterid,
       lu_stations.latitude,
       lu_stations.longitude,
       lu_stations.county,
       lu_stations.huc,
       lu_stations.smcshed,
       lu_stations.smc_lu,
       lu_stations.comid,
       vw_gismetrics_wide.psa6c,
       scape_strm_constraints.ref10,
       scape_strm_constraints.qt10,
       scape_strm_constraints.qt50,
       scape_strm_constraints.qt90,
       analysis_csci_core.sampledate AS csci_sampledate,
       max(analysis_csci_core.csci) AS csci_max,
       date_part('year'::text, analysis_csci_core.sampledate) AS year,
       max((
         CASE
         WHEN ((analysis_asci.assemblage)::text = 'Hybrid'::text) THEN analysis_asci.result
         ELSE NULL::character varying
         END)::text) AS h_asci_max,
       max((
         CASE
         WHEN ((analysis_asci.assemblage)::text = 'Diatom'::text) THEN analysis_asci.result
         ELSE NULL::character varying
         END)::text) AS d_asci_max,
       avg(analysis_chem_nutrients_0.total_n_mgl) AS total_n_all,
       avg(
         CASE
         WHEN ((analysis_chem_nutrients_0.total_n_mgl_method)::text = ANY (ARRAY['reported'::text, 'calculated'::text])) THEN analysis_chem_nutrients_0.total_n_mgl
         ELSE NULL::double precision
         END) AS total_n_rep_calc,
       avg(analysis_chem_nutrients_0.total_p_mgl) AS total_p_all,
       avg(
         CASE
         WHEN ((analysis_chem_nutrients_0.total_p_mgl_method)::text = ANY (ARRAY['reported'::text, 'calculated'::text])) THEN analysis_chem_nutrients_0.total_p_mgl
         ELSE NULL::double precision
         END) AS total_p_rep_calc,
       avg(analysis_combined_specificconductivity.result) AS cond,
       avg(analysis_ipi.ipi) AS ipi,
       avg(analysis_ipi.ev_flowhab) AS ev_flowhab,
       avg(analysis_ipi.ev_flowhab_score) AS ev_flowhab_score,
       avg(analysis_ipi.h_aqhab) AS h_aqhab,
       avg(analysis_ipi.h_aqhab_score) AS h_aqhab_score,
       avg(analysis_ipi.h_aqhab_pred) AS h_aqhab_pred,
       avg(analysis_ipi.h_subnat) AS h_subnat,
       avg(analysis_ipi.h_subnat_score) AS h_subnat_score,
       avg(analysis_ipi.pct_safn) AS pct_safn,
       avg(analysis_ipi.pct_safn_score) AS pct_safn_score,
       avg(analysis_ipi.pct_safn_pred) AS pct_safn_pred,
       avg(analysis_ipi.xcmg) AS xcmg,
       avg(analysis_ipi.xcmg_score) AS xcmg_score,
       avg(analysis_ipi.xcmg_pred) AS xcmg_pred,
       avg(analysis_ipi.pct_rc) AS pct_rc,
       avg(tblcramindexandattributescores.indexscore) AS cram_score,
       avg(tblcramindexandattributescores.bioticstructure) AS cram_bioticstructure,
       avg(tblcramindexandattributescores.bufferandlandscapecontext) AS cram_bufferandladscapecontext,
       avg(tblcramindexandattributescores.hydrology) AS cram_hydrology,
       avg(tblcramindexandattributescores.physicalstructure) AS cram_physicalstructure
       FROM ((((((((lu_stations
                    LEFT JOIN vw_gismetrics_wide ON (((lu_stations.masterid)::text = vw_gismetrics_wide.masterid)))
                   LEFT JOIN scape_strm_constraints ON (((lu_stations.comid)::text = (scape_strm_constraints.comid)::text)))
                  JOIN analysis_csci_core ON (((lu_stations.stationid)::text = (analysis_csci_core.stationcode)::text)))
                 LEFT JOIN analysis_asci ON ((((lu_stations.stationid)::text = (analysis_asci.stationcode)::text) AND (analysis_csci_core.sampledate = analysis_asci.sampledate) AND ((analysis_asci.metric)::text = 'ASCI'::text))))
                LEFT JOIN analysis_chem_nutrients_0 ON ((((lu_stations.masterid)::text = (analysis_chem_nutrients_0.masterid)::text) AND (analysis_csci_core.sampledate = analysis_chem_nutrients_0.sampledate))))
               LEFT JOIN analysis_combined_specificconductivity ON ((((lu_stations.masterid)::text = analysis_combined_specificconductivity.masterid) AND (analysis_csci_core.sampledate = (analysis_combined_specificconductivity.sampledate)::date) AND (analysis_combined_specificconductivity.analytename = 'SpecificConductivity'::text) AND (analysis_combined_specificconductivity.result > (0)::double precision))))
              LEFT JOIN analysis_ipi ON ((((lu_stations.stationid)::text = (analysis_ipi.stationcode)::text) AND (date_part('year'::text, analysis_csci_core.sampledate) = date_part('year'::text, analysis_ipi.sampledate)))))
             LEFT JOIN tblcramindexandattributescores ON ((((lu_stations.stationid)::text = (tblcramindexandattributescores.stationcode)::text) AND (date_part('year'::text, analysis_csci_core.sampledate) = date_part('year'::text, tblcramindexandattributescores.visitdate)))))
       GROUP BY lu_stations.masterid, lu_stations.stationid, lu_stations.latitude, lu_stations.longitude, lu_stations.county, lu_stations.comid, vw_gismetrics_wide.psa6c, scape_strm_constraints.ref10, scape_strm_constraints.qt10, scape_strm_constraints.qt50, scape_strm_constraints.qt90, analysis_csci_core.sampledate) t"
)) %>% as_tibble()


load("C:/Users/Raphaelm/Documents/Repositories/SQI/data/habglm.RData")
load("C:/Users/Raphaelm/Documents/Repositories/SQI/data/wqglm.RData")

#
sqi <- function(datin, wq_mod_in = NULL, hab_mod_in = NULL, lothrsh = 0.1, hithrsh = 0.9){
  
  # rf models as default
  if(is.null(wq_mod_in))
    wq_mod_in <- wqglm
  if(is.null(hab_mod_in))
    hab_mod_in <- habglm
  
  ##
  # probability of stress, chem, hab, and overall
  # model predicts probably of low stress
  
  # glm predictions
  datin$pChem <- predict(wq_mod_in, newdata = datin, type = "response")
  datin$pHab <- predict(hab_mod_in, newdata = datin, type = "response")
  
  # combo stress estimate
  datin$pChemHab<- 1 - ((1 - datin$pChem) * (1 - datin$pHab))
  
  out <- datin %>%
    dplyr::mutate(
      BiologicalCondition = ifelse(CSCI>=0.79 & ASCI>=0.83,"Healthy",
                                   ifelse(CSCI<0.79 & ASCI<0.83,"Impacted for CSCI and ASCI",
                                          ifelse(CSCI<0.79 & ASCI>=0.83,"Impacted for CSCI",
                                                 ifelse(CSCI>=0.79 & ASCI<0.83,"Impacted for ASCI", "XXXXX"
                                                 )))
      ),
      WaterChemistryCondition = cut(pChem,
                                    breaks = c(-Inf, lothrsh, hithrsh, Inf),
                                    labels = c('Low', 'Moderate', 'Severe'),
                                    right = F
      ),
      HabitatCondition = cut(pHab,
                             breaks = c(-Inf, lothrsh, hithrsh, Inf),
                             labels = c('Low', 'Moderate', 'Severe'),
                             right = F
      ),
      OverallStressCondition = cut(pChemHab,
                                   breaks = c(-Inf, lothrsh, hithrsh, Inf),
                                   labels = c('Low', 'Moderate', 'Severe'),
                                   right = F
      ),
      OverallStressCondition_detail = ifelse(pChemHab<hithrsh,"Low stress",
                                             ifelse(pChem>=hithrsh & pHab>=hithrsh, "Stressed by chemistry and habitat degradation",
                                                    ifelse(pChem>=hithrsh & pHab<hithrsh, "Stressed by chemistry degradation",
                                                           ifelse(pChem<hithrsh & pHab>hithrsh, "Stressed by habitat degradation",
                                                                  ifelse(pChem<hithrsh & pHab<hithrsh, "Stressed by low levels of chemistry or habitat degradation",
                                                                         "XXXXX"))))
      ),
      StreamHealthIndex = ifelse(BiologicalCondition=="Healthy" & OverallStressCondition!="Severe","Healthy and unstressed",
                                 ifelse(BiologicalCondition=="Healthy" & OverallStressCondition=="Severe","Healthy and resilient",
                                        ifelse(BiologicalCondition!="Healthy" & OverallStressCondition!="Severe","Impacted by unknown stress",
                                               ifelse(BiologicalCondition!="Healthy" & OverallStressCondition=="Severe","Impacted and stressed",
                                                      "XXXXX")))
      )
    ) %>% 
    dplyr::mutate_if(is.factor, as.character)
  
  return(out)
  
}

sqi_dat2 <-sqi(datin=sqi_dat %>%
                 mutate(TN=total_n_all,
                        TP=total_p_all,
                        Cond=cond,
                        hy=cram_hydrology,
                        PCT_SAFN=pct_safn_score,
                        XCMG=xcmg,
                        CSCI=csci_max,
                        ASCI=d_asci_max),
               wq_mod_in=wqglm,
               hab_mod_in = habglm)



library(sf)
psa_sf<-st_read("C:/Users/Raphaelm/Documents/Repositories/SMC_misc/Shapefiles/RWQCB/rwqcbnda.shp")

sqi_sf<-sqi_dat2 %>%
  st_as_sf(coords=c("longitude","latitude"),
           crs=4326)

ggplot()+
  geom_sf(data=psa_sf)+
  geom_sf(data=sqi_sf %>% filter(!is.na(StreamHealthIndex)), aes(color=StreamHealthIndex))+
  scale_color_viridis_d(name="SQI")+
  theme_bw()+
  facet_wrap(~StreamHealthIndex)+
  theme(axis.text = element_blank(),
        panel.grid = element_blank(),
        axis.ticks = element_blank(),
        panel.border = element_blank())
