library(tidyverse)
risk_veg<-read_csv("../DATA_O3/stats_O3_veg.csv")

#filter only areas with:
#Agricolture CLC raster values 12 (211), 13 (212), 14 (213), 18 (231),19 (241), 20 (242), 21 (243) and 22 (244)
#Horticolture CLC raster values 15 (221), 16 (222), 17 (223)
#(Semi-)natural vegetation CLC raster values 26 (321), 27 (322), 28 (323), 29 (324), 32 (333), 35 (411), 36 (412) and 37 (421)
risk_veg_agri<-risk_veg %>% filter(CLC %in% c(12, 13, 14, 18, 19, 20, 21, 22)) %>% mutate(CLC="AGRICOLTURE") %>% group_by(AOT, CLC) %>%summarise(AREA=sum(AREA)) 
risk_veg_horti<-risk_veg %>% filter(CLC %in% c(15, 16, 17)) %>% mutate(CLC="HORTICOLTURE") %>% group_by(AOT, CLC) %>%summarise(AREA=sum(AREA)) 
risk_veg_nase<-risk_veg %>% filter(CLC %in% c(26, 27, 28, 29, 32, 35, 36, 37)) %>% mutate(CLC="VEGETATION") %>% group_by(AOT, CLC) %>%summarise(AREA=sum(AREA)) 
risk_veg_all<-bind_rows(risk_veg_agri,risk_veg_horti,risk_veg_nase) %>% ungroup()

#total forest area in km^2 and by category:
tot<-risk_veg_all %>% group_by(CLC) %>% summarise(AREA=sum(AREA)/1e+06) %>%
  bind_rows(risk_veg_all %>% summarise(AREA=sum(AREA)/1e+06) %>% mutate(CLC="ALL"))

#Over UN limit for vegetation and agricolture and UE long term objective (AOT40 > 3000 ppbv/h - AOT column >= 1)
exc_lt<-risk_veg_all %>% filter(AOT%in%c("1","2","3")) %>% group_by(CLC) %>% summarise(AREA=sum(AREA)/1e+06) %>%
  bind_rows(risk_veg_all %>% filter(AOT%in%c("1","2","3")) %>% summarise(AREA=sum(AREA)/1e+06) %>% mutate(CLC="ALL"))

##Over UE limit (AOT40 > 3000 ppbv/h - AOT column == 3)
exc_ue<-risk_veg_all %>% filter(AOT=="3") %>% group_by(CLC) %>% summarise(AREA=sum(AREA)/1e+06) %>%
  bind_rows(risk_veg_all %>% filter(AOT=="3") %>% summarise(AREA=sum(AREA)/1e+06) %>% mutate(CLC="ALL"))

##Over UN limit for horticultural areas (AOT40 > 8000 ppbv/h - AOT column >= 2)
exc_un<-risk_veg_all %>% filter(AOT%in%c("2","3")) %>% group_by(CLC) %>% summarise(AREA=sum(AREA)/1e+06) %>%
  bind_rows(risk_veg_all %>% filter(AOT%in%c("2","3")) %>% summarise(AREA=sum(AREA)/1e+06) %>% mutate(CLC="ALL"))

#Get vegetation area where AQ data is not available (AOT column == *)
aqd<-risk_veg_all %>% filter(AOT=="*") %>% group_by(CLC) %>% summarise(AREA=sum(AREA)/1e+06) %>%
  bind_rows(risk_veg_all %>% filter(AOT=="*") %>% summarise(AREA=sum(AREA)/1e+06) %>% mutate(CLC="ALL"))

#create summary csv
col_n<-c("VEGETATION_TYPE", "TOTAL_AREA", "RISK_AREA_LT", "RISK_AREA_UE", "RISK_AREA_UN", "%RISK_AREA_LT", "%RISK_AREA_UE", "%RISK_AREA_UN", "%AREA_AQ_DATA")
tot_sum<-tot %>% inner_join(exc_lt, by="CLC", suffix=c("_TOTAL","_RISK_LT")) %>% inner_join(exc_ue, by="CLC") %>% inner_join(exc_un, by="CLC", suffix=c("_RISK_UE","_RISK_UN")) %>% 
  inner_join(aqd, by="CLC") %>%
  mutate(RISK_AREA_LT_PER = round((AREA_RISK_LT/AREA_TOTAL)*100,2),
         RISK_AREA_UE_PER = round((AREA_RISK_UE/AREA_TOTAL)*100,2),
         RISK_AREA_UN_PER = round((AREA_RISK_UN/AREA_TOTAL)*100,2),
         AQ_AREA_PER = round((1-AREA/AREA_TOTAL)*100,2)) %>% select(-AREA) %>% rename_all(~col_n)
write_csv(tot_sum,"DATI_O3/risk_area_veg.csv")
