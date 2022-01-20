library(tidyverse)
risk_for<-read_csv("../DATA_O3/stats_O3_for.csv")

#filter only areas with forest: CLC raster values 23 (311 - Broad-leaved forest), 24 (312 - Coniferous forest) and 25 (313 - Mixed forest)
risk_for<-risk_for %>% filter(CLC %in% c(23, 24, 25)) 

#total forest area in km^2 and by category:
tot<-risk_for %>% group_by(CLC) %>% summarise(AREA=sum(AREA)/1e+06) %>%
  bind_rows(risk_for %>% summarise(AREA=sum(AREA)/1e+06) %>% mutate(CLC=1))

#Get at risk area (AOT40 > 5000 ppbv/h - AOT column == 1)
exc<-risk_for %>% filter(AOT=="1") %>% group_by(CLC) %>% summarise(AREA=sum(AREA)/1e+06) %>%
  bind_rows(risk_for %>% filter(AOT=="1") %>% summarise(AREA=sum(AREA)/1e+06) %>% mutate(CLC=1))

#Get forest area where AQ data is available (AOT column != *)
aqd<-risk_for %>% filter(AOT=="*") %>% group_by(CLC) %>% summarise(AREA=sum(AREA)/1e+06) %>%
  bind_rows(risk_for %>% filter(AOT=="*") %>% summarise(AREA=sum(AREA)/1e+06) %>% mutate(CLC=1))

#create summary csv
col_n<-c("FOREST_TYPE", "TOTAL_AREA", "RISK_AREA", "%RISK_AREA", "%AREA_AQ_DATA")
tot_sum<-tot %>% inner_join(exc, by="CLC", suffix=c("_TOTAL","_RISK")) %>% inner_join(aqd, by="CLC") %>% 
  mutate(RISK_AREA_PER = round((AREA_RISK/AREA_TOTAL)*100,2),
         AQ_AREA_PER = round((1-AREA/AREA_TOTAL)*100,2), 
         CLC = case_when(CLC==1 ~ "ALL",
                         CLC==23 ~ "BROAD-LEAVED",
                         CLC==24 ~ "CONIFEROUS",
                         CLC==25 ~ "MIXED")) %>% select(-AREA) %>% rename_all(~col_n)
write_csv(tot_sum,"DATI_O3/risk_area_for.csv")
