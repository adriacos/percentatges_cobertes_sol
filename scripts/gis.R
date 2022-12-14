
save_as_gis <- function(){
  ifn <- get_ifn4()
  ifn <- as(ifn, "Spatial")
  ifn <- ifn[,"plot_id"]
  
  #mirar com fer per crear columnes amb noms variables
  # for(y in c("09", "18")){
  #   for(r in c(4,100)){
  #     if(y=="09"){
  #       rw <- read.csv("./output/perc_cob_sol_ifn4_2009_4m_raw.csv")
  #       rc <- read.csv("./output/perc_cob_sol_ifn4_2009_4m_recl.csv")
  #     }else if(y=="18"){
  #       
  #     }
  #    
  #   }
  # }
  # 
  
  r4_09_rw <- read.csv("./output/perc_cob_sol_ifn4_2009_4m_raw.csv")
  r4_09_rc <- read.csv("./output/perc_cob_sol_ifn4_2009_4m_recl.csv")
  
  r100_09_rw <- read.csv("./output/perc_cob_sol_ifn4_2009_100m_raw.csv")
  r100_09_rc <- read.csv("./output/perc_cob_sol_ifn4_2009_100m_recl.csv")
  
  ifn$r4_09_BC <- r4_09_rc$BC
  ifn$r4_09_AG <- r4_09_rc$AG
  ifn$r4_09_UB <- r4_09_rc$UB
  ifn$r4_09_PT <- r4_09_rc$PT
  ifn$r4_09_RC <- r4_09_rc$RC
  ifn$r4_09_AC <- r4_09_rc$AC
  ifn$r4_09_ZH <- r4_09_rc$ZH
  ifn$r4_09_LT <- r4_09_rc$LT
  ifn$r4_09_MT <- r4_09_rc$MT
  
  ifn$r100_09_BC <- r100_09_rc$BC
  ifn$r100_09_AG <- r100_09_rc$AG
  ifn$r100_09_UB <- r100_09_rc$UB
  ifn$r100_09_PT <- r100_09_rc$PT
  ifn$r100_09_RC <- r100_09_rc$RC
  ifn$r100_09_AC <- r100_09_rc$AC
  ifn$r100_09_ZH <- r100_09_rc$ZH
  ifn$r100_09_LT <- r100_09_rc$LT
  ifn$r100_09_MT <- r100_09_rc$MT
  
  ifn$r4_09_1 <- r4_09_rw$X1
  ifn$r4_09_2 <- r4_09_rw$X2
  ifn$r4_09_3 <- r4_09_rw$X3
  ifn$r4_09_4 <- r4_09_rw$X4
  ifn$r4_09_5 <- r4_09_rw$X5
  ifn$r4_09_6 <- r4_09_rw$X6
  ifn$r4_09_7 <- r4_09_rw$X7
  ifn$r4_09_8 <- r4_09_rw$X8
  ifn$r4_09_9 <- r4_09_rw$X9
  ifn$r4_09_10 <- r4_09_rw$X10
  ifn$r4_09_11 <- r4_09_rw$X11
  ifn$r4_09_12 <- r4_09_rw$X12
  ifn$r4_09_13 <- r4_09_rw$X13
  ifn$r4_09_14 <- r4_09_rw$X14
  ifn$r4_09_15 <- r4_09_rw$X15
  ifn$r4_09_16 <- r4_09_rw$X16
  ifn$r4_09_17 <- r4_09_rw$X17
  ifn$r4_09_18 <- r4_09_rw$X18
  ifn$r4_09_19 <- r4_09_rw$X19
  ifn$r4_09_20 <- r4_09_rw$X20
  ifn$r4_09_21 <- r4_09_rw$X21
  ifn$r4_09_22 <- r4_09_rw$X22
  ifn$r4_09_23 <- r4_09_rw$X23
  ifn$r4_09_24 <- r4_09_rw$X24
  ifn$r4_09_25 <- r4_09_rw$X25
  ifn$r4_09_26 <- r4_09_rw$X26
  ifn$r4_09_27 <- r4_09_rw$X27
  ifn$r4_09_28 <- r4_09_rw$X28
  ifn$r4_09_29 <- r4_09_rw$X29
  ifn$r4_09_30 <- r4_09_rw$X30
  ifn$r4_09_31 <- r4_09_rw$X31
  ifn$r4_09_32 <- r4_09_rw$X32
  ifn$r4_09_33 <- r4_09_rw$X33
  ifn$r4_09_34 <- r4_09_rw$X34
  ifn$r4_09_35 <- r4_09_rw$X35
  ifn$r4_09_36 <- r4_09_rw$X36
  ifn$r4_09_37 <- r4_09_rw$X37
  ifn$r4_09_38 <- r4_09_rw$X38
  ifn$r4_09_39 <- r4_09_rw$X39
  ifn$r4_09_40 <- r4_09_rw$X40
  ifn$r4_09_41 <- r4_09_rw$X41
  
  ifn$r100_09_1 <- r100_09_rw$X1
  ifn$r100_09_2 <- r100_09_rw$X2
  ifn$r100_09_3 <- r100_09_rw$X3
  ifn$r100_09_4 <- r100_09_rw$X4
  ifn$r100_09_5 <- r100_09_rw$X5
  ifn$r100_09_6 <- r100_09_rw$X6
  ifn$r100_09_7 <- r100_09_rw$X7
  ifn$r100_09_8 <- r100_09_rw$X8
  ifn$r100_09_9 <- r100_09_rw$X9
  ifn$r100_09_10 <- r100_09_rw$X10
  ifn$r100_09_11 <- r100_09_rw$X11
  ifn$r100_09_12 <- r100_09_rw$X12
  ifn$r100_09_13 <- r100_09_rw$X13
  ifn$r100_09_14 <- r100_09_rw$X14
  ifn$r100_09_15 <- r100_09_rw$X15
  ifn$r100_09_16 <- r100_09_rw$X16
  ifn$r100_09_17 <- r100_09_rw$X17
  ifn$r100_09_18 <- r100_09_rw$X18
  ifn$r100_09_19 <- r100_09_rw$X19
  ifn$r100_09_20 <- r100_09_rw$X20
  ifn$r100_09_21 <- r100_09_rw$X21
  ifn$r100_09_22 <- r100_09_rw$X22
  ifn$r100_09_23 <- r100_09_rw$X23
  ifn$r100_09_24 <- r100_09_rw$X24
  ifn$r100_09_25 <- r100_09_rw$X25
  ifn$r100_09_26 <- r100_09_rw$X26
  ifn$r100_09_27 <- r100_09_rw$X27
  ifn$r100_09_28 <- r100_09_rw$X28
  ifn$r100_09_29 <- r100_09_rw$X29
  ifn$r100_09_30 <- r100_09_rw$X30
  ifn$r100_09_31 <- r100_09_rw$X31
  ifn$r100_09_32 <- r100_09_rw$X32
  ifn$r100_09_33 <- r100_09_rw$X33
  ifn$r100_09_34 <- r100_09_rw$X34
  ifn$r100_09_35 <- r100_09_rw$X35
  ifn$r100_09_36 <- r100_09_rw$X36
  ifn$r100_09_37 <- r100_09_rw$X37
  ifn$r100_09_38 <- r100_09_rw$X38
  ifn$r100_09_39 <- r100_09_rw$X39
  ifn$r100_09_40 <- r100_09_rw$X40
  ifn$r100_09_41 <- r100_09_rw$X41
  
  writeOGR(ifn, "./output", "ifn_cob", driver= "ESRI Shapefile", overwrite_layer=T)
}