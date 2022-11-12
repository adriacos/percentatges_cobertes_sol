
library(rgdal)

calc_max_1 <- function(df){
  sub("X", "", unlist(lapply(df$plot_id, function(x){
    if(all(is.na(df[df$plot_id==x,2:ncol(df)]))){
      return(NA)
    }else{
      return(names(sort(df[df$plot_id==x,2:ncol(df)], T)[1]))
    }
  }
  )))
}
calc_max_2 <- function(df){
  sub("X", "", unlist(lapply(df$plot_id, function(x){
    if(all(is.na(df[df$plot_id==x,2:ncol(df)]))){
      return(NA)
    }else{
      return(names(sort(df[df$plot_id==x,2:ncol(df)], T)[2]))
    }
  }
  )))
}
calc_max_3 <- function(df){
  sub("X", "", unlist(lapply(df$plot_id, function(x){
    if(all(is.na(df[df$plot_id==x,2:ncol(df)]))){
      return(NA)
    }else{
      return(names(sort(df[df$plot_id==x,2:ncol(df)], T)[3]))
    }
  }
  )))
}

calc_max <- function(){
  
  r4_09_rw <- read.csv("./output/perc_cob_sol_ifn4_2009_4m_raw.csv")
  r4_09_rc <- read.csv("./output/perc_cob_sol_ifn4_2009_4m_recl.csv")
  
  r100_09_rw <- read.csv("./output/perc_cob_sol_ifn4_2009_100m_raw.csv")
  r100_09_rc <- read.csv("./output/perc_cob_sol_ifn4_2009_100m_recl.csv")

  #mirar com fer per crear columnes amb noms variables
  # for(y in c("09", "18")){
  #   for(r in c(4,100)){
  #     if(y=="09"){
  #       rw <- read.csv("./output/perc_cob_sol_ifn4_2009_4m_raw.csv")
  #       rc <- read.csv("./output/perc_cob_sol_ifn4_2009_4m_recl.csv")
  #     }else if(y=="18"){
  #       rw <- read.csv("./output/perc_cob_sol_ifn4_2018_4m_raw.csv")
  #       rc <- read.csv("./output/perc_cob_sol_ifn4_2018_4m_recl.csv")
  #     }
  #    
  #   }
  # }
  # 
  
  
  mx2409rw <- sub("X", "", unlist(lapply(r4_09_rw$X, function(x){
    if(all(is.na(r4_09_rw[r4_09_rw$X==x,2:ncol(r4_09_rw)]))){
      return(NA)
    }else{
      return(names(sort(r4_09_rw[r4_09_rw$X==x,2:ncol(r4_09_rw)], T)[2]))
    }
  }
  )))
  
  mx3409rw <- sub("X", "", unlist(lapply(r4_09_rw$X, function(x){
    if(all(is.na(r4_09_rw[r4_09_rw$X==x,2:ncol(r4_09_rw)]))){
      return(NA)
    }else{
      return(names(sort(r4_09_rw[r4_09_rw$X==x,2:ncol(r4_09_rw)], T)[3]))
    }
  }
  )))
  
  mx1409rw <- sub("X", "", unlist(lapply(r4_09_rw$X, function(x){
    if(all(is.na(r4_09_rw[r4_09_rw$X==x,2:ncol(r4_09_rw)]))){
      return(NA)
    }else{
      return(names(sort(r4_09_rw[r4_09_rw$X==x,2:ncol(r4_09_rw)], T)[1]))
    }
  }
  )))
  
  imx210009rw <- sub("X", "", unlist(lapply(r100_09_rw$X, function(x){
    if(all(is.na(r100_09_rw[r100_09_rw$X==x,2:ncol(r100_09_rw)]))){
      return(NA)
    }else{
      return(names(sort(r100_09_rw[r100_09_rw$X==x,2:ncol(r100_09_rw)], T)[2]))
    }
  }
  )))
  
  mx310009rw <- sub("X", "", unlist(lapply(r100_09_rw$X, function(x){
    if(all(is.na(r100_09_rw[r100_09_rw$X==x,2:ncol(r100_09_rw)]))){
      return(NA)
    }else{
      return(names(sort(r100_09_rw[r100_09_rw$X==x,2:ncol(r100_09_rw)], T)[3]))
    }
  }
  )))
  
  mx110009rw <- sub("X", "", unlist(lapply(r100_09_rw$X, function(x){
    if(all(is.na(r100_09_rw[r100_09_rw$X==x,2:ncol(r100_09_rw)]))){
      return(NA)
    }else{
      return(names(sort(r100_09_rw[r100_09_rw$X==x,2:ncol(r100_09_rw)], T)[1]))
    }
  }
  )))
  
  mx2409rc <- sub("X", "", unlist(lapply(r4_09_rc$X, function(x){
    if(all(is.na(r4_09_rc[r4_09_rc$X==x,2:ncol(r4_09_rc)]))){
      return(NA)
    }else{
      return(names(sort(r4_09_rc[r4_09_rc$X==x,2:ncol(r4_09_rc)], T)[2]))
    }
  }
  )))
  
  mx3409rc <- sub("X", "", unlist(lapply(r4_09_rc$X, function(x){
    if(all(is.na(r4_09_rc[r4_09_rc$X==x,2:ncol(r4_09_rc)]))){
      return(NA)
    }else{
      return(names(sort(r4_09_rc[r4_09_rc$X==x,2:ncol(r4_09_rc)], T)[3]))
    }
  }
  )))
  
  mx1409rc <- sub("X", "", unlist(lapply(r4_09_rc$X, function(x){
    if(all(is.na(r4_09_rc[r4_09_rc$X==x,2:ncol(r4_09_rc)]))){
      return(NA)
    }else{
      return(names(sort(r4_09_rc[r4_09_rc$X==x,2:ncol(r4_09_rc)], T)[1]))
    }
  }
  )))
  
  
  mx210009rc <- sub("X", "", unlist(lapply(r100_09_rc$X, function(x){
    if(all(is.na(r100_09_rc[r100_09_rc$X==x,2:ncol(r100_09_rc)]))){
      return(NA)
    }else{
      return(names(sort(r100_09_rc[r100_09_rc$X==x,2:ncol(r100_09_rc)], T)[2]))
    }
  }
  )))
  
  mx310009rc <- sub("X", "", unlist(lapply(r100_09_rc$X, function(x){
    if(all(is.na(r100_09_rc[r100_09_rc$X==x,2:ncol(r100_09_rc)]))){
      return(NA)
    }else{
      return(names(sort(r100_09_rc[r100_09_rc$X==x,2:ncol(r100_09_rc)], T)[3]))
    }
  }
  )))
  
  mx110009rc <- sub("X", "", unlist(lapply(r100_09_rc$X, function(x){
    if(all(is.na(r100_09_rc[r100_09_rc$X==x,2:ncol(r100_09_rc)]))){
      return(NA)
    }else{
      return(names(sort(r100_09_rc[r100_09_rc$X==x,2:ncol(r100_09_rc)], T)[1]))
    }
  }
  )))

  
  df <- df[,c("plot_id", "mx2409rw","mx3409rw","mx1409rw","mx210009rw","mx310009rw","mx110009rw","mx2409rc","mx3409rc","mx1409rc","mx210009rc","mx310009rc","mx110009rc")]
  names(df) <- c("plot_id","mx2_r4_09_rw","mx3_r4_09_rw","mx1_r4_09_rw","mx2_r100_09_rw","mx3_r100_09_rw","mx1_r100_09_rw","mx2_r409_rc","mx3_r4_09_rc","mx1_r4_09_rc","mx2_r100_09_rc","mx3_r100_09_rc","mx1_r100_09_rc")
  df <- df[c("plot_id","mx1_r4_09_rw","mx2_r4_09_rw","mx3_r4_09_rw","mx1_r100_09_rw","mx2_r100_09_rw","mx3_r100_09_rw","mx1_r4_09_rc","mx2_r409_rc","mx3_r4_09_rc","mx1_r100_09_rc","mx2_r100_09_rc","mx3_r100_09_rc")]
  write.csv(df, "./output/perc_cob_sol_ifn4_2009_max.csv")
  
 
}


