mx2100 <- table(unlist(lapply(r100$X, function(x){
  if(all(is.na(r100[r100$X==x,2:9]))){
    return(NA)
    }else{
      return(names(sort(r100[r100$X==x,2:9], T)[2]))
      }
    }
  )))

mx3100 <- table(unlist(lapply(r100$X, function(x){
  if(all(is.na(r100[r100$X==x,2:9]))){
    return(NA)
  }else{
    return(names(sort(r100[r100$X==x,2:9], T)[3]))
  }
}
)))

mx1100 <- table(unlist(lapply(r100$X, function(x){
  names(which.max(r100[r100$X==x,2:9]))
  }
  )))



mx2200 <- table(unlist(lapply(r200$X, function(x){
  if(all(is.na(r200[r200$X==x,2:9]))){
    return(NA)
  }else{
    return(names(sort(r200[r200$X==x,2:9], T)[2]))
  }
}
)))

mx3200 <- table(unlist(lapply(r200$X, function(x){
  if(all(is.na(r200[r200$X==x,2:9]))){
    return(NA)
  }else{
    return(names(sort(r200[r200$X==x,2:9], T)[3]))
  }
}
)))

mx1200 <- table(unlist(lapply(r200$X, function(x){
  names(which.max(r200[r200$X==x,2:9]))
}
)))


mx2500 <- table(unlist(lapply(r500$X, function(x){
  if(all(is.na(r500[r500$X==x,2:9]))){
    return(NA)
  }else{
    return(names(sort(r500[r500$X==x,2:9], T)[2]))
  }
}
)))

mx3500 <- table(unlist(lapply(r500$X, function(x){
  if(all(is.na(r500[r500$X==x,2:9]))){
    return(NA)
  }else{
    return(names(sort(r500[r500$X==x,2:9], T)[3]))
  }
}
)))

mx1500 <- table(unlist(lapply(r500$X, function(x){
  names(which.max(r500[r500$X==x,2:9]))
}
)))


draw <- function(){
  
  ifn <- get_ifn4()
  
  ifn$r100_BC <- r100$BC
  ifn$r100_AG <- r100$AG
  ifn$r100_UB <- r100$UB
  ifn$r100_PT <- r100$PT
  ifn$r100_RC <- r100$RC
  ifn$r100_AC <- r100$AC
  ifn$r100_ZH <- r100$ZH
  ifn$r100_LT <- r100$LT
  
  ifn$r500_BC <- r500$BC
  ifn$r500_AG <- r500$AG
  ifn$r500_UB <- r500$UB
  ifn$r500_PT <- r500$PT
  ifn$r500_RC <- r500$RC
  ifn$r500_AC <- r500$AC
  ifn$r500_ZH <- r500$ZH
  ifn$r500_LT <- r500$LT
  
  ifn$mx1_100 <- unlist(lapply(r100$X, function(x){
    if(all(is.na(r100[r100$X==x,2:9]))){
      return(NA)
    }else{
      return(names(sort(r100[r100$X==x,2:9], T)[1]))
    }
  }
  ))
  ifn$mx2_100 <- unlist(lapply(r100$X, function(x){
    if(all(is.na(r100[r100$X==x,2:9]))){
      return(NA)
    }else{
      return(names(sort(r100[r100$X==x,2:9], T)[2]))
    }
  }
  ))
  ifn$mx3_100 <- unlist(lapply(r100$X, function(x){
    if(all(is.na(r100[r100$X==x,2:9]))){
      return(NA)
    }else{
      return(names(sort(r100[r100$X==x,2:9], T)[3]))
    }
  }
  ))
  
  ifn$mx1_500 <- unlist(lapply(r500$X, function(x){
    if(all(is.na(r500[r500$X==x,2:9]))){
      return(NA)
    }else{
      return(names(sort(r500[r500$X==x,2:9], T)[1]))
    }
  }
  ))
  ifn$mx2_500 <- unlist(lapply(r500$X, function(x){
    if(all(is.na(r500[r500$X==x,2:9]))){
      return(NA)
    }else{
      return(names(sort(r500[r500$X==x,2:9], T)[2]))
    }
  }
  ))
  ifn$mx3_500 <- unlist(lapply(r500$X, function(x){
    if(all(is.na(r500[r500$X==x,2:9]))){
      return(NA)
    }else{
      return(names(sort(r500[r500$X==x,2:9], T)[3]))
    }
  }
  ))
  
  ifn <- ifn[,c("plot_id", 
                "r100_BC", "r100_AG", "r100_UB", "r100_PT", "r100_RC", "r100_AC", "r100_ZH", "r100_LT", 
                "r500_BC", "r500_AG", "r500_UB", "r500_PT", "r500_RC", "r500_AC", "r500_ZH", "r500_LT",
                "mx1_100", "mx2_100", "mx3_100", "mx1_500", "mx2_500", "mx3_500")]
  
  ifn <- as(ifn, "Spatial")
  
  ifn <- reproject_EPSG_25831_vect(ifn)
  
  writeOGR(ifn, "./output", "ifn_cob", driver= "ESRI Shapefile", overwrite_layer=T)
}
