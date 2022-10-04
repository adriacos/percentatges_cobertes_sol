
get_ifn4 <- function(){
  print(paste(Sys.time(), "get_ifn4", sep="-"))
  #st_read("C:/Users/a.cos/Documents/Tesi/DADES/ALPENS/IFN_3_ALPENS.gpkg")
  st_read("C:/Users/a.cos/Documents/Tesi/DADES/IFN/IFN_3_CAT.gpkg")
}

get_mcsc_2018 <- function(){
  print(paste(Sys.time(), "get_mcsc_2018", sep="-"))
  #raster("C:\\Users\\a.cos\\Documents\\Tesi\\DADES\\ALPENS\\MCSC_2018_ALPENS_RAST.tif")
  raster("C:\\Users\\a.cos\\Documents\\Tesi\\DADES\\MCSC\\cobertes-sol-v1r0-2018.tif")
}

get_mcsc_2009 <- function(){
  print(paste(Sys.time(), "get_mcsc_2009", sep="-"))
  #raster("C:\\Users\\a.cos\\Documents\\Tesi\\DADES\\ALPENS\\MCSC_2018_ALPENS_RAST.tif")
  raster("C:\\Users\\a.cos\\Documents\\Tesi\\DADES\\MCSC\\cobertes-sol-v1r0-2009.tif")
}