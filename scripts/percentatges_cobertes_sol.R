source("./scripts/get_data.R")
source("./scripts/project.R")


library(raster)
library(sf)
library(parallel)
library(snow)
library(sp)
library(rgeos)
library(exactextractr)
library(SpaDES)


ini <- function(){
  #radius <- c(100,200,250,300,500,1000,2000,2500,3000,5000,10000)
  radius <- c(500,1000,2000,2500,3000,5000,10000)
  sapply(radius, ini_)
}



ini_ <- function(radius){
  print(paste(Sys.time(), "ini", sep="-"))
  print(radius)
 
 
  if(radius<500){
    ifn4 <- get_ifn4()
    ifn4 <- as(ifn4,"Spatial")
    ifn4 <- project_EPSG_25831_vect(ifn4)
  } else {
    ifn4 <- get_ifn4_all_prov()
    plot_ids <- lapply(ifn4, get_plot_ids)
    ifn4 <- lapply(ifn4, as, "Spatial")
    ifn4 <- lapply(ifn4, SpatialPoints)
    ifn4 <- lapply(ifn4, project_EPSG_25831_vect)
  }
  
  print(paste(Sys.time(), "extract", sep="-"))
  
  for(year in c(2009,2018)){
    if (year==2009){
      if (radius<500){
        mcsc <- project_EPSG_25831_rast(get_mcsc_2009())
      }
      else{
        mcsc <- lapply(get_mcsc_2009_all_prov(), project_EPSG_25831_rast)
      }
    }else{
      if (radius<500){
        mcsc <- project_EPSG_25831_rast(get_mcsc_2018())
      }
      else{
        mcsc <- lapply(get_mcsc_2018_all_prov(), project_EPSG_25831_rast)
      }
    }
    
    if (radius<500){
      extr <- exact_extract(mcsc, gBuffer(ifn4,byid=T,width=radius))
    }else{
      extr <- mapply(exact_extract, mcsc, lapply(ifn4, gBuffer, byid=T,width=radius))
    }
    
    rm(mcsc)
    gc()
    
    
    time <- Sys.time()
    n.cores <- detectCores()
    if(radius==100){
      clust <- makeCluster(3)
      clusterExport(clust, c("extr","fill_missing_categories"), envir = environment())
      prop <- parLapply(clust, extr, function(e){table(e$value)})
      prop <- parLapply(clust, prop, calc_prop)
      stopCluster(clust)
      names(prop) <- ifn4$plot_id
    }else if (radius < 500){
      clust <- makeCluster(2)
      clusterExport(clust, c("extr","fill_missing_categories"), envir = environment())
      prop <- parLapply(clust, extr, function(e){table(e$value)})
      prop <- parLapply(clust, prop, calc_prop)
      stopCluster(clust)
      names(prop) <- ifn4$plot_id
    }else{
      prop <- list()
      for (i in 1:length(extr)){
        ex <- extr[[i]]
        clust <- makeCluster(2)
        clusterExport(clust, c("ex","fill_missing_categories"), envir = environment())
        pr <- parLapply(clust, ex, function(e){table(e$value)})
        pr <- parLapply(clust, pr, calc_prop)
        stopCluster(clust)
        names(pr) <- plot_ids[[i]]
        prop <- append(prop, pr)
      }
      rm(ex)
      rm(pr)
      prop <- do.call(rbind, prop)
    } 

    rm(ifn4)
    gc()
    
    prop <- do.call(rbind, prop)
    if(year==2009){
      write.csv(prop,paste("./output/perc_cob_sol_ifn4_2009_",radius,"m_raw.csv", sep=""))
    }else{
      write.csv(prop,paste("./output/perc_cob_sol_ifn4_2018_",radius,"m_raw.csv", sep=""))
    }
    prop <- reclass(prop)
    if (year==2009){
      write.csv(prop,paste("./output/perc_cob_sol_ifn4_2009_",radius,"m_recl.csv", sep=""))
    }else{
      write.csv(prop,paste("./output/perc_cob_sol_ifn4_2018_",radius,"m_recl.csv", sep=""))
    }
    rm(clust)
    rm(prop)
    gc()
  }
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
  df <- cbind(df, BC = rowSums(df[,c("7","8","9","11","12","13","15","16","17")]))
  df <- cbind(df, PT = df[,"14"])
  df <- cbind(df, MT = df[,"10"])
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

get_plot_ids <- function(ifn4){
  ifn4$plot_id
}