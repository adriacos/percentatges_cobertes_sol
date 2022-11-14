
library('parallel')

rasterize_siose <- function(){
  names <- sub("_GPKG","", sub("C:/Users/acosd/Desktop/CREAF/Mapes/Cobertes/SIOSE//","",list.dirs("C:/Users/acosd/Desktop/CREAF/Mapes/Cobertes/SIOSE/")))  
  names <- names[2:length(names)]
  for(name in names){
    print(name)
    if(file.exists(paste("C:/Users/acosd/Desktop/CREAF/Mapes/Cobertes/SIOSE/",name,"_GPKG/",name,".gpkg", sep=""))){
      vect <- readOGR(paste("C:/Users/acosd/Desktop/CREAF/Mapes/Cobertes/SIOSE/",name,"_GPKG/",name,".gpkg", sep=""))
    } else{
      stop(paste(name, "does not exist"))
    }
    
    rast = raster()
    extent(rast) = extent(vect) 
    res(rast) = 2
    
 
    # no_cores <- detectCores() - 1
    # # Number of polygons features in SPDF
    # features <- 1:nrow(vect[,])
    # # Split features in n parts
    # n <- 50
    # parts <- split(features, cut(features, n))
    # # Initiate cluster (after loading all the necessary object to R environment: BRA_adm2, parts, r.raster, n)
    # cl <- makeCluster(no_cores)
    # clusterExport(cl, c("rast", "vect", "parts"))
    # # Parallelize rasterize function
    # system.time(rParts <- parLapply(cl = cl, X = 1:n, fun = function(x) rasterize(vect[parts[[x]],], rast, 'CODIIGE')))
    # stopCluster(cl)
    # 
    # rast <- do.call(merge, rParts)
    
    rast <- rasterize(vect, rast, 'CODIIGE')
    
    writeRaster(rast, paste("C:/Users/acosd/Desktop/CREAF/Mapes/Cobertes/SIOSE/", name, ".tif", sep=""))
  }
}




