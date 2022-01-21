library(tidyverse)
library(lubridate)
NDVI_risk<-read_csv("../DATA_O3/NDVI/Sentinel-2 L2A-3_NDVI-risk_clip2.csv") %>% select(dte=`C0/date`, mean=`C0/mean`, p10=`C0/p10`, p90=`C0/p90`) %>% mutate(so="Above AOT40 limit")
NDVI_not_risk<-read_csv("../DATA_O3/NDVI/Sentinel-2 L2A-3_NDVI-norisk_clip2.csv") %>% select(dte=`C0/date`, mean=`C0/mean`, p10=`C0/p10`, p90=`C0/p90`)%>% mutate(so="Below AOT40 limit")

#Select only dates available in both datasets, remove 1 low value for both datasets 
NDVI <- bind_rows(NDVI_risk, NDVI_not_risk) %>% 
  filter(dte%in%(c(NDVI_not_risk$dte, NDVI_risk$dte)[duplicated(c(NDVI_not_risk$dte, NDVI_risk$dte))]), mean>0.1) %>%
  mutate(Year=year(dte), Month=as.factor(month(dte))) %>% 
  filter(Year!=2016)

plyear<-ggplot(NDVI, aes(x=so, y=mean, fill=Month)) + geom_boxplot() 

#Select only year 2019, "summer" months
NDVI <- NDVI %>% filter(Year==2019, Month%in%c(5,6,7,8,9))

pl2019sm<-ggplot(NDVI, aes(x=so, y=mean, fill=Month)) + geom_boxplot() + ylab("NDVI") + theme_bw() + theme(axis.title.x = element_blank()) + ggtitle("2019 NDVI")

#Compute average 2019 value
NDVI %>% group_by(so) %>% summarise(NDVI=mean(mean))

#Statistical test: p0>0.05 No significant difference between samples
NDVI %>% rstatix::kruskal_test(mean~so)

ggsave("../DATA_O3/NDVI/boxplot_NDVI.png",pl2019sm,width = 20, height=20, units="cm" )
