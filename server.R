library(CoreAPIV2)
library(magrittr)

source("R Code/marker_table.R")
source("R Code/parental_verification.R")
source("R Code/marker_eval.R")

function(input, output,session) {
  
    observeEvent(input$verify,{
       
      mt<- marker_table(isolate(input$os_barcode) )  
      
      if( all(mt[4,-1] == TRUE,na.rm = TRUE)) { 
        output$verified <- renderText("Parents Verified")} else {
          output$verified <- renderText("Parents Not Verified")
          }
      
    dt <- t(mt)
    
    rownames(dt) <- colnames(mt)
    output$marker_table<-  renderTable(dt,rownames = T,colnames = F)
   })

  
  
  
   
  
  
  
  
  
  
  
  
  
  
  
  }

