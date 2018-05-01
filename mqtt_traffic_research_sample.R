library(readxl)
library(ggplot2)

temp_list <- list()
for(i in 1:30) {
  dataset_path <- paste0(getwd(),'/data_set/',i,"_04_mqtt.xlsx")
  temp_list[[paste0("day_",i,sep="")]] <- read_excel(dataset_path,sheet = "groupvalue",col_names = FALSE)
  if(i>1){
    temp_list[[i]][1] <- NULL
  }
}
df_sample <- as.data.frame(temp_list)

for(i in 1:ncol(df_sample)){
  ifelse(i==1,colnames(df_sample)[i] <- "interval", colnames(df_sample)[i] <- (paste0('day_',i-1)))
}

ggplot(df_sample,aes(x=df_sample$day_10)) + 
  geom_density(fill='white')


for (i in 1:29){
  if(i==1){
  x <- as.numeric(unlist(temp_list[[i]][2]))
  y <- as.numeric(unlist(temp_list[[i+1]]))
 print(wilcox.test(x,y, paired = TRUE))
  }
  else {
    x <- as.numeric(unlist(temp_list[[i]]))
    y <- as.numeric(unlist(temp_list[[i+1]]))
    print(wilcox.test(x,y, paired = TRUE))
  }
}

warnings()
