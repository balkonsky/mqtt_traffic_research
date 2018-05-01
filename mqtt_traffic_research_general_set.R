library(ggplot2)
library(xlsx)

list_general_set <- list()
for(i in 1:30) {
  dataset_path <- paste0(getwd(),'/data_set/',i,"_04_mqtt.xlsx")
  list_general_set <- read.xlsx(dataset_path,sheetIndex = 2, colIndex = 3)
}

df_general <- as.data.frame(list_general_set)
colnames(df_general) <- c("sec_pack_interval")

mean(df_general$sec_pack_interval)
sd(df_general$sec_pack_interval)
range(df_general$sec_pack_interval)

ggplot(df_general,aes(df_general$sec_pack_interval))+
  geom_density(fill='white')
