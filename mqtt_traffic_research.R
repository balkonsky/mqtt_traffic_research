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
df <- as.data.frame(temp_list)

for(i in 1:ncol(df)){
  ifelse(i==1,colnames(df)[i] <- "interval", colnames(df)[i] <- (paste0('day_',i-1)))
}

ggplot(df,aes(x=df$day_10)) + 
  geom_density(fill='white')


ggplot(df,aes(x=df$day_10))+
  geom_dotplot(binwidth = 3)

ggplot(df, aes(x = df$day_10))+
  geom_histogram(fill= 'white', col = 'black', binwidth = 1)


wilcox.test(df$day_21, df$day_22,paired = TRUE)
