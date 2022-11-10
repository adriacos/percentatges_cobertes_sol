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