
library(raster)

extract <- function(vectors, rast){
  vectors$id___ <- 1:length(vectors)
  ids <- vectors$id___
  clust <- makeCluster(detectCores()-1, outfile="log_extract.txt")
  clusterExport(clust, list("ids", "vectors", "rast", "extract_", "extract__"), envir=environment())
  clusterEvalQ(clust, list(library(raster)))
  extr <- parLapplyLB(clust, ids, extract_, vectors, rast)
  #extr <- lapply(ids, extract_, vectors, rast)
  stopCluster(clust)
  rm(ids)
  rm(clust)
  gc()
  extr
}

extract_ <- function(id, vectors, rast){
  print(id)
  extract__(vectors[vectors$id___==id,], rast)
}

extract__ <- function(vect, rast){
  r <- crop(rast, vect)
  r <- mask(r, vect)
  table(values(r))
}