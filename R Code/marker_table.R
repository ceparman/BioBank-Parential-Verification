
marker_table<- function(os_barcode)

{
  

  
  api <- CoreAPIV2::coreAPI("account-bb.json")
  
  creds <- CoreAPIV2::authBasic(api)
  
  creds <- creds$coreApi


  headers <- c('Content-Type' = "application/json;odata.metadata=minimal", accept = "application/json")
  
  resource <- "PET"
  query <-paste0("('",os_barcode,"')?$expand=PET_MOTHER,PET_FATHER")
  

  
  pet<- CoreAPIV2::apiGET(coreApi = creds,resource = resource, query = query,headers = headers,useVerbose = TRUE )
  
  f_barcode <- pet$content$PET_FATHER$Barcode
  m_barcode <-  pet$content$PET_MOTHER$Barcode
  
  print(is.null(m_barcode))
  
  
  m_table <-parental_varification(creds,os_barcode,m_barcode,f_barcode)
    
  lo<- CoreAPIV2::logOut(creds)
  
  m_table
}