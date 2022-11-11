
get_ifn4_BCN <- function(){
  print(paste(Sys.time(), "get_ifn4", sep="-"))
  st_read("C:/Users/a.cos/Documents/Tesi/DADES/IFN/IFN_3_BCN.gpkg")
}
get_ifn4_TAR <- function(){
  print(paste(Sys.time(), "get_ifn4", sep="-"))
  st_read("C:/Users/a.cos/Documents/Tesi/DADES/IFN/IFN_3_TAR.gpkg")
}
get_ifn4_GIR <- function(){
  print(paste(Sys.time(), "get_ifn4", sep="-"))
  st_read("C:/Users/a.cos/Documents/Tesi/DADES/IFN/IFN_3_GIR.gpkg")
}
get_ifn4_LLE <- function(){
  print(paste(Sys.time(), "get_ifn4", sep="-"))
  st_read("C:/Users/a.cos/Documents/Tesi/DADES/IFN/IFN_3_LLE.gpkg")
}
get_ifn4_all_prov <- function(){
  list("BCN"=get_ifn4_BCN(), "TAR"=get_ifn4_TAR(), "GIR"=get_ifn4_GIR(), "LLE"=get_ifn4_LLE())
}


get_ifn4 <- function(){
  print(paste(Sys.time(), "get_ifn4", sep="-"))
  #st_read("C:/Users/a.cos/Documents/Tesi/DADES/IFN/IFN_3_CAT.gpkg")
  st_read("C:/Users/acosd\\Desktop\\CREAF\\IFN3\\IFN_3_CAT.gpkg")
}

get_quads <- function(){
  print(paste(Sys.time(), "get_quads", sep="-"))
  st_read("C:/Users/acosd/Desktop/CREAF/Mapes/Quadricula/10kmx10km_CAT.gpkg")
}


get_mcsc_2018_BCN <- function(){
  print(paste(Sys.time(), "get_mcsc_2018", sep="-"))
  raster("C:\\Users\\a.cos\\Documents\\Tesi\\DADES\\MCSC\\cobertes-sol-v1r0-2018_BCN_buf10000.tif")
}
get_mcsc_2018_TAR <- function(){
  print(paste(Sys.time(), "get_mcsc_2018", sep="-"))
  raster("C:\\Users\\a.cos\\Documents\\Tesi\\DADES\\MCSC\\cobertes-sol-v1r0-2018_TAR_buf10000.tif")
}
get_mcsc_2018_GIR <- function(){
  print(paste(Sys.time(), "get_mcsc_2018", sep="-"))
  raster("C:\\Users\\a.cos\\Documents\\Tesi\\DADES\\MCSC\\cobertes-sol-v1r0-2018_GIR_buf10000.tif")
}
get_mcsc_2018_LLE <- function(){
  print(paste(Sys.time(), "get_mcsc_2018", sep="-"))
  raster("C:\\Users\\a.cos\\Documents\\Tesi\\DADES\\MCSC\\cobertes-sol-v1r0-2018_LLE_buf10000.tif")
}
get_mcsc_2018_all_prov <- function(){
  list("BCN"=get_mcsc_2018_BCN(), "TAR"=get_mcsc_2018_TAR(), "GIR"=get_mcsc_2018_GIR(), "LLE"=get_mcsc_2018_LLE())
}
get_mcsc_2018 <- function(){
  print(paste(Sys.time(), "get_mcsc_2018", sep="-"))
  #raster("C:\\Users\\a.cos\\Documents\\Tesi\\DADES\\MCSC\\cobertes-sol-v1r0-2018.tif")
  raster("C:\\Users\\acosd\\Desktop\\CREAF\\Mapes\\Cobertes\\MCSC\\cobertes-sol-v1r0-2018.tif")
}



get_mcsc_2009_BCN <- function(){
  print(paste(Sys.time(), "get_mcsc_2009", sep="-"))
  raster("C:\\Users\\a.cos\\Documents\\Tesi\\DADES\\MCSC\\cobertes-sol-v1r0-2009_BCN_buf10000.tif")
}
get_mcsc_2009_TAR <- function(){
  print(paste(Sys.time(), "get_mcsc_2009", sep="-"))
  raster("C:\\Users\\a.cos\\Documents\\Tesi\\DADES\\MCSC\\cobertes-sol-v1r0-2009_TAR_buf10000.tif")
}
get_mcsc_2009_GIR <- function(){
  print(paste(Sys.time(), "get_mcsc_2009", sep="-"))
  raster("C:\\Users\\a.cos\\Documents\\Tesi\\DADES\\MCSC\\cobertes-sol-v1r0-2009_GIR_buf10000.tif")
}
get_mcsc_2009_LLE <- function(){
  print(paste(Sys.time(), "get_mcsc_2009", sep="-"))
  raster("C:\\Users\\a.cos\\Documents\\Tesi\\DADES\\MCSC\\cobertes-sol-v1r0-2009_LLE_buf10000.tif")
}
get_mcsc_2009_all_prov <- function(){
  list("BCN"=get_mcsc_2009_BCN(), "TAR"=get_mcsc_2009_TAR(), "GIR"=get_mcsc_2009_GIR(), "LLE"=get_mcsc_2009_LLE())
}
get_mcsc_2009 <- function(){
  print(paste(Sys.time(), "get_mcsc_2009", sep="-"))
  #raster("C:\\Users\\a.cos\\Documents\\Tesi\\DADES\\MCSC\\cobertes-sol-v1r0-2009.tif")
  raster("C:\\Users\\acosd\\Desktop\\CREAF\\Mapes\\Cobertes\\MCSC\\cobertes-sol-v1r0-2009.tif")
}