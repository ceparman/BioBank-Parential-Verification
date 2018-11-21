

marker_eval <- function(marker_alleles)
{
  
#  md alleles in order of offspring mother father
  
  possible <- NULL
  
  for(m in 1:2){
    
    for(f in 1:2)
      
    {
      ma <- stringr::str_split(marker_alleles[2]," ")[[1]][m]
      fa <- stringr::str_split(marker_alleles[3]," ")[[1]][f]
      possible <- c(possible, paste(ma,fa),paste(fa,ma))
      
    }
    
    
  }
  
  
  marker_alleles[1] %in% possible  
  
  
}



#marker_alleles <- md$BB_PDM_AHT121

