


build_m_marker_query<- function(marker_name,os_marker,m_marker)
{
  
  #if this is the sex chromsome return XY for a male
  
  if( (os_marker %in% c("X X","Y X")) | (m_marker %in% c("X X","Y X")) ){
    
    return ( paste0("(contains(",marker_name,",'Y X') or ",
                    marker_name," eq null)" 
                    )
             
    )
  } else if ( is.na(os_marker) ) { return(NA)  #os is missing
  

  
  } else if ( is.na(m_marker) ) {return(NA)    #mother in missing

  
  } else if  (m_marker == os_marker){   #mother equals os
    
   #father could be either os marker  
    
    markers <- strsplit(os_marker," ")
    
    if(markers[[1]][1] != markers[[1]][2]) {
    
    query <- paste0("(contains(",marker_name,",'",markers[[1]][1],"') or ",
                              "contains(",marker_name,",'",markers[[1]][2],"') or ",
                               marker_name," eq null)"
                    )
    } else {
      
      query <- paste0("(contains(",marker_name,",'",markers[[1]][1],"') or ",
                      marker_name," eq null)"
      )
      
      
    }
      
    
   return(query)
  } else {
  
  #exact father marked known, father is the marker not in offspring 
  
  os_markers <- strsplit(os_marker," ")
 
  m_markers <- strsplit(m_marker," ")
  
  # f_marker1<-m_markers[[1]][!unlist(m_markers) %in% unlist(os_markers)]
  # 
  # f_marker2<-os_markers[[1]][!unlist(os_markers) %in% unlist(m_markers)]
  # 
  # f_marker <- c(f_marker1,f_marker2)
  
  if( os_markers[[1]][1] %in% unlist(m_markers)   ) 
   
    {f_marker <- os_markers[[1]][2]
  } else f_marker <- os_markers[[1]][1]
  
  query <- paste0("(contains(",marker_name,",'",f_marker,"') or ",
                    marker_name," eq null)"
       )
  return(query)
  }
}

build_m_marker_query(marker_name,os_marker,m_marker)
