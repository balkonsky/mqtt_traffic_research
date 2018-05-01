library(ggplot2)
library(xlsx)

temp_list <- list()
for(i in 1:30) {
  dataset_path <- paste0(getwd(),'/data_set/',i,"_04_mqtt.xlsx")
  temp_list <- read.xlsx(dataset_path,sheetIndex = 2, colIndex = 3)
}

df_general <- as.data.frame(temp_list)
colnames(df_general) <- c("sec_pack_interval")

summary(df_general)
var(df_general$sec_pack_interval)
sd(df_general$sec_pack_interval)

ggplot(df_general,aes(df_general$sec_pack_interval))+
  geom_density(fill='white')
