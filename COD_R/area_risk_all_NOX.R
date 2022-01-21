library(tidyverse)
risk_veg<-read_csv("../DATA_NOX/CSV/stats_NOX_all.csv")

#filter only areas with:
#Agricolture CLC raster values 12 (211), 13 (212), 14 (213), 18 (231),19 (241), 20 (242), 21 (243) and 22 (244)
#Horticolture CLC raster values 15 (221), 16 (222), 17 (223)
#(Semi-)natural vegetation CLC raster values 26 (321), 27 (322), 28 (323), 29 (324), 32 (333), 35 (411), 36 (412) and 37 (421)
#Forest  CLC raster values 23 (311 - Broad-leaved forest), 24 (312 - Coniferous forest) and 25 (313 - Mixed forest)
risk_veg_agri<-risk_veg %>% filter(CLC %in% c(12, 13, 14, 18, 19, 20, 21, 22)) %>% mutate(CLC="AGRICOLTURE") %>% group_by(NOX, CLC) %>%summarise(AREA=sum(AREA)) 
risk_veg_horti<-risk_veg %>% filter(CLC %in% c(15, 16, 17)) %>% mutate(CLC="HORTICOLTURE") %>% group_by(NOX, CLC) %>%summarise(AREA=sum(AREA)) 
risk_veg_nase<-risk_veg %>% filter(CLC %in% c(26, 27, 28, 29, 32, 35, 36, 37)) %>% mutate(CLC="VEGETATION") %>% group_by(NOX, CLC) %>%summarise(AREA=sum(AREA))
risk_for<-risk_veg %>% filter(CLC %in% c(23, 24, 25)) %>% mutate(CLC="FOREST") %>% group_by(NOX, CLC) %>%summarise(AREA=sum(AREA))
risk_veg_all<-bind_rows(risk_veg_agri,risk_veg_horti,risk_veg_nase,risk_for) %>% ungroup()

#total forest area in km^2 and by category:
tot<-risk_veg_all %>% group_by(CLC) %>% summarise(AREA=sum(AREA)/1e+06) %>%
  bind_rows(risk_veg_all %>% summarise(AREA=sum(AREA)/1e+06) %>% mutate(CLC="ALL"))

#Over UN limit for vegetation and agricolture and UE long term objective (NOX > 30 µg/m3 - NOX column == 1)
exc<-risk_veg_all %>% filter(NOX=="1") %>% group_by(CLC) %>% summarise(AREA=sum(AREA)/1e+06) %>%
  bind_rows(risk_veg_all %>% filter(NOX=="1") %>% summarise(AREA=sum(AREA)/1e+06) %>% mutate(CLC="ALL"))

#Get vegetation area where AQ data is not available (NOX column == *)
aqd<-risk_veg_all %>% filter(NOX=="*") %>% group_by(CLC) %>% summarise(AREA=sum(AREA)/1e+06) %>%
  bind_rows(risk_veg_all %>% filter(NOX=="*") %>% summarise(AREA=sum(AREA)/1e+06) %>% mutate(CLC="ALL"))

#create summary csv
col_n<-c("VEGETATION_TYPE", "TOTAL_AREA", "RISK_AREA", "%RISK_AREA", "%AREA_AQ_DATA")
tot_sum<-tot %>% left_join(exc, by="CLC", suffix=c("_TOTAL","_RISK")) %>% 
  inner_join(aqd, by="CLC") %>%
  mutate(RISK_AREA_PER = round((AREA_RISK/AREA_TOTAL)*100,2),
         AQ_AREA_PER = round((1-AREA/AREA_TOTAL)*100,2)) %>% select(-AREA) %>% rename_all(~col_n)
write_csv(tot_sum,"../DATA_NOX/CSV/risk_area_all.csv")
