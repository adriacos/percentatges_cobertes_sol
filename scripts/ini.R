source("./scripts/get_data.R")
source("./scripts/project.R")
source("./scripts/extract.R")
source("./scripts/db_connect.R")
source("./scripts/calcs.R")
source("./scripts/gis.R")

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
  radius <- c(4, 100)
  # radius <- c(1000,2000,2500,3000,5000,10000)
  # sapply(radius, ini__)
  #radius <- 4
  sapply(radius, ini_)
}


#fer la funció extract pròpia per intentar evitar el problema amb els NA

ini_ <- function(radius){
  print(paste(Sys.time(), "ini", sep="-"))
  print(radius)
  
  ccaa <- get_ccaa()
  
  if(radius<50000){
    
    for(ca in ccaa){
      
    }
    
    ifn4 <- get_ifn4()
    ifn4 <- as(ifn4,"Spatial")
    ifn4 <- project_EPSG_25831_vect(ifn4)
    
    for(year in c(2009,2018)){
      if (year==2009){
        mcsc <- project_EPSG_25831_rast(get_mcsc_2009())
      }else{
        mcsc <- project_EPSG_25831_rast(get_mcsc_2018())
      }
      extr <- extract(gBuffer(ifn4,byid=T,width=radius), mcsc)
      #extr <- exact_extract(mcsc, gBuffer(ifn4,byid=T,width=radius))
      rm(mcsc)
      gc()
      
      time <- Sys.time()
      n.cores <- detectCores()-2
      if(radius<=100){
        clust <- makeCluster(3)
        clusterExport(clust, c("extr","fill_missing_categories"), envir = environment())
        #prop <- parLapply(clust, extr, function(e){table(e$value)})
        prop <- parLapply(clust, extr, calc_prop)
        stopCluster(clust)
        names(prop) <- ifn4$plot_id
      }else if (radius < 500){
        clust <- makeCluster(2)
        clusterExport(clust, c("extr","fill_missing_categories"), envir = environment())
        #prop <- parLapply(clust, extr, function(e){table(e$value)})
        prop <- parLapply(clust, extr, calc_prop)
        stopCluster(clust)
        names(prop) <- ifn4$plot_id
      }else{
        prop <- lapply(extr, calc_prop)
        names(prop) <- ifn4$plot_id
      }
      rm(extr)
      #rm(ifn4)
      gc()
      
      prop <- do.call(rbind, prop)
      prop <- as.data.frame(prop)
      plot_id <- rownames(prop)
      prop <- cbind(plot_id, prop)
      rownames(prop) <- NULL
      mx <-calc_max_1(prop) 
      mx2 <-calc_max_2(prop)  
      mx3 <-calc_max_3(prop)  
      prop$mx <- mx
      prop$mx2 <- mx2
      prop$mx3 <- mx3
      rm(mx)
      rm(mx2)
      rm(mx3)
      
      if(year==2009){
        write.csv(prop,paste("./output/perc_cob_sol_ifn4_2009_",radius,"m_raw.csv", sep=""))
        db_save(prop, paste("perc_cob_sol_ifn4_2009_",radius,"m_raw", sep=""))
      }else{
        write.csv(prop,paste("./output/perc_cob_sol_ifn4_2018_",radius,"m_raw.csv", sep=""))
        db_save(prop, paste("perc_cob_sol_ifn4_2018_",radius,"m_raw", sep=""))
      }
      prop <- reclass(prop)
      prop <- cbind(plot_id, prop)
      rownames(prop) <- NULL
      rm(plot_id)
      mx <-calc_max_1(prop) 
      mx2 <-calc_max_2(prop)  
      mx3 <-calc_max_3(prop)  
      prop$mx <- mx
      prop$mx2 <- mx2
      prop$mx3 <- mx3
      rm(mx)
      rm(mx2)
      rm(mx3)  
      if (year==2009){
        write.csv(prop,paste("./output/perc_cob_sol_ifn4_2009_",radius,"m_recl.csv", sep=""))
        db_save(prop, paste("perc_cob_sol_ifn4_2009_",radius,"m_recl", sep=""))
      }else{
        write.csv(prop,paste("./output/perc_cob_sol_ifn4_2018_",radius,"m_recl.csv", sep=""))
        db_save(prop, paste("perc_cob_sol_ifn4_2018_",radius,"m_recl", sep=""))
      }
      rm(clust)
      rm(prop)
      gc()
    }
  }
  # } else{
  #   provs <- c("BCN", "TAR", "GIR", "LLE")
  #   raw_provs_2009 <- NULL
  #   raw_provs_2018 <- NULL
  #   recl_provs_2009 <- NULL
  #   recl_provs_2018 <- NULL
  #   for(prov in provs){
  #     if(prov=="BCN"){ifn4<-get_ifn4_BCN()}else if(prov=="TAR"){ifn4<-get_ifn4_TAR()}else if(prov=="GIR"){ifn4<-get_ifn4_GIR()}else if(prov=="LLE"){ifn4<-get_ifn4_LLE()}
  #     ifn4 <- st_cast(ifn4, "POINT")
  #     ifn4 <- as(ifn4,"Spatial")
  #     #ifn4 <- SpatialPointsDataFrame(ifn4)
  #     ifn4 <- project_EPSG_25831_vect(ifn4)
  #     
  #     for(year in c(2009,2018)){
  #       if (year==2009){
  #         if(prov=="BCN"){mcsc<-get_mcsc_2009_BCN()}else if(prov=="TAR"){mcsc<-get_mcsc_2009_TAR()}else if(prov=="GIR"){mcsc<-get_mcsc_2009_GIR()}else if(prov=="LLE"){mcsc<-get_mcsc_2009_LLE()}
  #       }else{
  #         if(prov=="BCN"){mcsc<-get_mcsc_2018_BCN()}else if(prov=="TAR"){mcsc<-get_mcsc_2018_TAR()}else if(prov=="GIR"){mcsc<-get_mcsc_2018_GIR()}else if(prov=="LLE"){mcsc<-get_mcsc_2018_LLE()}
  #       }
  #       mcsc <- project_EPSG_25831_rast(mcsc)
  #       extr <- exact_extract(mcsc, gBuffer(ifn4,byid=T,width=radius))
  #       rm(mcsc)
  #       gc()
  #       
  #       # clust <- makeCluster(2)
  #       # clusterExport(clust, c("extr","fill_missing_categories"), envir = environment())
  #       # prop <- parLapply(clust, extr, function(e){table(e$value)})
  #       # prop <- parLapply(clust, prop, calc_prop)
  #       # stopCluster(clust)
  #       
  #       prop <- lapply(extr, function(e){table(e$value)})
  #       #rm(extr)
  #       prop <- lapply(prop, calc_prop)
  #       
  #       names(prop) <- ifn4$plot_id
  #       rm(ifn4)
  #       gc()
  #       
  #       prop <- do.call(rbind, prop)
  #       prop <- as.data.frame(prop)
  #       if(year==2009){
  #         if(is.null(raw_provs_2009)){
  #           raw_provs_2009 <- prop
  #         }else{
  #           raw_provs_2009 <- rbind(raw_provs_2009, prop)  
  #         }
  #       }else{
  #         if(is.null(raw_provs_2009)){
  #           raw_provs_2018 <- prop
  #         }else{
  #           raw_provs_2018 <- rbind(raw_provs_2018, prop)  
  #         }
  #       }
  #       prop <- reclass(prop)
  #       if (year==2009){
  #         if(is.null(raw_provs_2009)){
  #           recl_provs_2009 <- prop
  #         }else{
  #           recl_provs_2009 <- rbind(recl_provs_2009, prop)  
  #         }
  #       }else{
  #         if(is.null(recl_provs_2018)){
  #           recl_provs_2018 <- prop
  #         }else{
  #           recl_provs_2018 <- rbind(recl_provs_2018, prop)  
  #         }
  #       }
  #       rm(clust)
  #       rm(prop)
  #       gc()
  #     }
  #   }
  #   #raw_provs_2009 <- do.call(rbind(raw_provs_2009))
  #   write.csv(raw_provs_2009,paste("./output/perc_cob_sol_ifn4_2009_", radius,"m_raw.csv", sep=""))
  #   #raw_provs_2018 <- do.call(rbind(raw_provs_2018))
  #   write.csv(raw_provs_2018,paste("./output/perc_cob_sol_ifn4_2018_", radius,"m_raw.csv", sep=""))
  #   #recl_provs_2009 <- do.call(rbind(recl_provs_2009))
  #   write.csv(recl_provs_2009,paste("./output/perc_cob_sol_ifn4_2009_", radius,"m_recl.csv", sep=""))
  #   #recl_provs_2018 <- do.call(rbind(recl_provs_2018))
  #   write.csv(recl_provs_2018,paste("./output/perc_cob_sol_ifn4_2018_", radius,"m_recl.csv", sep=""))
  #   rm(raw_provs_2009)
  #   rm(raw_provs_2018)
  #   rm(recl_provs_2009)
  #   rm(recl_provs_2018)
  #   gc()
  # }
  print(paste(Sys.time(), "extract", sep="-"))
}


fill_missing_categories <- function(tab){
  cat <- as.character(1:41)
  cat <- cat[!(cat %in% names(tab))]
  tab[cat] <- 0
  tab[order(as.numeric(names(tab)))]
}

calc_prop <- function(tab){
  tab <- tab/sum(tab)
  # if(length(tab)==1){
  #   return(NA)
  # }else{
    return(fill_missing_categories(tab))
  # }
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
  

  df <- df[,c("BC","MT","AG","UB","PT","RC","AC","ZH","LT")]
  #df[is.na(df)] <- 0
  df
} 

get_plot_ids <- function(ifn4){
  ifn4$plot_id
}



ini__ <- function(radius){
  print(paste(Sys.time(), "ini", sep="-"))
  print(radius)
  
    quads <- get_quads()
    quads <- as(quads,"Spatial")
    quads <- project_EPSG_25831_vect(quads)
    quads$id <- as.numeric(row.names(quads))
    if(quads[1,]$id == 0){
      quads$id <- quads$id+1
    }
    
    ifn4 <- get_ifn4()
    ifn4 <- as(ifn4,"Spatial")
    ifn4 <- project_EPSG_25831_vect(ifn4)
    for (year in c(2009, 2018)){
      print(year)
      
      raw <- NULL
      recl <- NULL
      
      if (year==2009){
        mcsc <- project_EPSG_25831_rast(get_mcsc_2009())
      }else{
        mcsc <- project_EPSG_25831_rast(get_mcsc_2018())
      }
      
      for(quad_id in quads$id){
        print(quad_id)
        tryCatch(
          expr = {
            ifn4_ <- crop(ifn4, quads[quads$id==quad_id,])
          },
          error = function(e){ 
            if(grepl("cannot derive coordinates from non-numeric matrix", e)){
            #if(e=="<simpleError in .local(obj, ...): cannot derive coordinates from non-numeric matrix>"){
              print(e)
            }else{
              stop(e)
            }
          }
        )
        if(!exists("ifn4_")){
          next()
        }
        #ifn4_ <- crop(ifn4, quads[quads$id==quad_id,])
        #ifn4_ <- mask(ifn4_, quads[quads$id==quad_id,])
        
        #mcsc_ <- crop(mcsc, buffer(quads[quads$id==quad_id,], width=10000, dissolve=T))
        #mcsc_ <- mask(mcsc_, buffer(quads[quads$id==quad_id,], width=10000, dissolve=T))
        
        extr <- exact_extract(mcsc, gBuffer(ifn4_,byid=T,width=radius))
        #rm(mcsc_)
        gc()
        
        # prop <- lapply(extr, function(e){table(e$value)})
        # prop <- lapply(prop, calc_prop)
        
        clust <- makeCluster(detectCores()-1)
        clusterExport(clust, c("extr","fill_missing_categories"), envir = environment())
        prop <- parLapply(clust, extr, function(e){table(e$value)})
        #prop <- parLapply(clust, prop, calc_prop)
        stopCluster(clust)
        
        # prop <- lapply(extr, function(e){table(e$value)})
        prop <- lapply(prop, calc_prop)
        
        names(prop) <- ifn4_$plot_id
        rm(ifn4_)
        gc()
        
        prop <- do.call(rbind, prop)
        prop <- as.data.frame(prop)
        if(year==2009){
          if(is.null(raw)){
            raw <- prop
          }else{
            raw <- rbind(raw, prop)  
          }
        }else{
          if(is.null(raw)){
            raw <- prop
          }else{
            raw <- rbind(raw, prop)  
          }
        }
        
        prop <- reclass(prop)
        if (year==2009){
          if(is.null(recl)){
            recl <- prop
          }else{
            recl <- rbind(recl, prop)  
          }
        }else{
          if(is.null(recl)){
            recl <- prop
          }else{
            recl <- rbind(recl, prop)  
          }
        }
        #rm(clust)
        rm(prop)
        gc()
      }
      if(year==2009){
        write.csv(raw,paste("./output/perc_cob_sol_ifn4_2009_", radius,"m_raw.csv", sep=""))
        write.csv(recl,paste("./output/perc_cob_sol_ifn4_2009_", radius,"m_recl.csv", sep=""))
      }else{
        write.csv(raw,paste("./output/perc_cob_sol_ifn4_2018_", radius,"m_raw.csv", sep=""))
        write.csv(recl,paste("./output/perc_cob_sol_ifn4_2018_", radius,"m_recl.csv", sep=""))
      }
    }
    rm(ifn4)
    rm(mcsc)
    gc()
    
    # write.csv(raw_2009,paste("./output/perc_cob_sol_ifn4_2009_", radius,"m_raw.csv", sep=""))
    # write.csv(raw_2018,paste("./output/perc_cob_sol_ifn4_2018_", radius,"m_raw.csv", sep=""))
    # write.csv(recl_2009,paste("./output/perc_cob_sol_ifn4_2009_", radius,"m_recl.csv", sep=""))
    # write.csv(recl_2018,paste("./output/perc_cob_sol_ifn4_2018_", radius,"m_recl.csv", sep=""))
    rm(raw)
    rm(recl)
    gc()
  print(paste(Sys.time(), "extract", sep="-"))
}


crop_ifn_by_quad <- function(){
  quads <- get_quads()
  quads <- as(quads,"Spatial")
  quads <- project_EPSG_25831_vect(quads)
  quads$id <- as.numeric(row.names(quads))
  if(quads[1,]$id == 0){
    quads$id <- quads$id+1
  }
  ifn4 <- get_ifn4()
  ifn4 <- as(ifn4,"Spatial")
  ifn4 <- project_EPSG_25831_vect(ifn4)
  
  mcsc_2009 <- project_EPSG_25831_rast(get_mcsc_2009())
  mcsc_2018 <- project_EPSG_25831_rast(get_mcsc_2018())
  
  for(quad_id in quads$id){
    print(quad_id)
    tryCatch(
      expr = {
        ifn4_ <- crop(ifn4, quads[quads$id==quad_id,])
      },
      error = function(e){ 
        if(grepl("cannot derive coordinates from non-numeric matrix", e)){
          #if(e=="<simpleError in .local(obj, ...): cannot derive coordinates from non-numeric matrix>"){
          print(e)
        }else{
          stop(e)
        }
      }
    )
    if(!exists("ifn4_")){
      next()
    }
  
    mcsc_2009_ <- crop(mcsc, buffer(quads[quads$id==quad_id,], width=10000, dissolve=T))
    mcsc_2018_ <- crop(mcsc, buffer(quads[quads$id==quad_id,], width=10000, dissolve=T))
    
    writeRaster(mcsc_2009_, paste("./files/mcsc2009/",quad_id,".tif", sep=""))
    writeRaster(mcsc_2018_, paste("./files/mcsc2009/",quad_id,".tif", sep=""))
    writeOGR(ifn4_, "./files/ifn4", quad_id)
  }
}


