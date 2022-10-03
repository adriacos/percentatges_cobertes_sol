source("./scripts/get_data.R")
library(raster)
library(sf)
library(parallel)
library(snow)


ini <- function(radius){
  print(paste(Sys.time(), "ini", sep="-"))
  
 
  ifn4 <- get_ifn4()
  mcsc_2018 <- get_mcsc_2018()
  
  n.cores <- detectCores()
  
  print(paste(Sys.time(), "extract", sep="-"))
  time <- Sys.time()
  
  #beginCluster(n.cores)
  extr <- extract(mcsc_2018, ifn4, buffer=radius)
  #endCluster()

  print(as.numeric(difftime(Sys.time(),time,units="secs")))
  
  time <- Sys.time()
  
  clust <- makeCluster(n.cores)
  clusterExport(clust, c("extr","fill_missing_categories"))
  prop <- parLapply(clust, extr, table)
  prop <- parLapply(clust, prop, calc_prop)
  stopCluster(clust)
  
  print(as.numeric(difftime(Sys.time(),time,units="secs")))
  
  names(prop) <- ifn4$plot_id
  prop <- do.call(rbind, prop)
  write.csv(prop,paste("./output/perc_cob_sol_ifn4_2018_",radius,"m_raw.csv", sep=""))
  prop <- reclass(prop)
  write.csv(prop,paste("./output/perc_cob_sol_ifn4_2018_",radius,"m_recl.csv", sep=""))
  #prop
}

fill_missing_categories <- function(tab){
  cat <- as.character(1:41)
  cat <- cat[!(cat %in% names(tab))]
  tab[cat] <- 0
  tab[order(as.numeric(names(tab)))]
}

calc_prop <- function(tab){
  tab <- tab/sum(tab)
  if(length(tab)==1){
    return(NA)
  }else{
    return(fill_missing_categories(tab))
  }
}

reclass <- function(df){
  #print(paste(Sys.time(), "reclass", sep="-"))
  df <- cbind(df, LT = rowSums(df[,c("41","19")]))
  df <- cbind(df, AG = rowSums(df[,c("1","2","3","4","5","6")]))
  df <- cbind(df, BC = rowSums(df[,c("7","8","9","10","11","12","13","15","16","17")]))
  df <- cbind(df, PT = df[,"14"])
  df <- cbind(df, RC = df[,"18"])
  df <- cbind(df, ZH = df[,"20"])
  df <- cbind(df, UB = rowSums(df[,c("21","22","23","24","25","26","27","28","29","30","31","32","33","34","35")]))
  df <- cbind(df, AC = rowSums(df[,c("36","37","38","39","40")]))
  
  
  # df$LT <- rowSums(df[,c("41","19")], na.rm=T)  
  # df$AG <- rowSums(df[c("1","2","3","4","5","6")], na.rm=T)
  # df$BC <- rowSums(df[c("7","8","9","10","11","12","13","15","16","17")], na.rm=T)
  # df$PT <- rowSums(df[c("14")], na.rm=T) 
  # df$RC <- rowSums(df[c("18")], na.rm=T) 
  # df$ZH <- rowSums(df[c("20")], na.rm=T)
  # df$UB <- rowSums(df[c("21","22","23","24","25","26","27","28","29","30","31","32","33","34","35")], na.rm=T)
  # df$AC <- rowSums(df[c("36","37","38","39","40")], na.rm=T)
  
  df <- df[,c("BC","AG","UB","PT","RC","AC","ZH","LT")]
  #df[is.na(df)] <- 0
  df
} 