library(readxl)
library(ggplot2)
library(xlsx)

list_sample <- list()
for(i in 1:30) {
  dataset_path <- paste0(getwd(),'/data_set/',i,"_04_mqtt.xlsx")
  list_sample[[paste0("day_",i,sep="")]] <- read_excel(dataset_path,sheet = "groupvalue",col_names = FALSE)
  row_name <- as.vector(unlist(list_sample[[i]][1]))
  list_sample[[i]][1] <- NULL
}
df_sample <- as.data.frame(list_sample)
for(i in 1:ncol(df_sample)){
  colnames(df_sample)[i] <- (paste0('day_',i))
}
row.names(df_sample) <- row_name


list_descriptive_statistics_sample <- list()
for(i in 1:length(list_sample)){
    list_descriptive_statistics_sample[[paste0("day_",i,sep="")]] <- ""
    list_descriptive_statistics_sample[[paste0("day_",i,sep="")]][1] <- (mean(as.numeric(unlist(list_sample[[i]]))))
    list_descriptive_statistics_sample[[paste0("day_",i,sep="")]][2] <- (sd(as.numeric(unlist(list_sample[[i]]))))
    list_descriptive_statistics_sample[[paste0("day_",i,sep="")]][3] <- (min(as.numeric(unlist(list_sample[[i]]))))
    list_descriptive_statistics_sample[[paste0("day_",i,sep="")]][4] <- (max(as.numeric(unlist(list_sample[[i]]))))
}
df_descriptive_statistics_sample <- as.data.frame(list_descriptive_statistics_sample)


x <- data.frame()
for(i in 1:ncol(df_sample)){
x <- rbind(x, data.frame(v=as.vector(unlist(list_sample[[i]])), type=paste0('day_',i)))
}
ggplot(data=x) + 
  geom_density(aes(x = v, fill=type, color=type),alpha = 0.2, stat = "density", position = "identity")+
  theme_bw() +
  theme(plot.title=element_text(size = rel(1.6), face = "bold"),
        legend.position = "bottom",
        legend.background = element_rect(colour = "gray"),
        legend.key = element_rect(fill = "gray90"),
        axis.title = element_text(face = "bold", size = 13)) 


for (i in 1:(length(list_sample)-1)){
    x <- as.numeric(unlist(list_sample[[i]]))
    y <- as.numeric(unlist(list_sample[[i+1]]))
    print(wilcox.test(x,y, paired = TRUE))
}

