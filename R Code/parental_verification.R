

parental_varification <- function(creds,os_barcode,m_barcode,f_barcode)

{
  


#get marker data



resource <- "TESTPETMARKER"

query <-paste0("?$filter=BB_PETMRK_SUBJECT eq '", os_barcode,"' and Active eq TRUE")
query <- URLencode(query)

headers <- c('Content-Type' = "application/json;odata.metadata=minimal", accept = "application/json")

osmd<- CoreAPIV2::apiGET(coreApi = creds,resource = resource, query = query,headers = headers,useVerbose = TRUE )


query <-paste0("?$filter=BB_PETMRK_SUBJECT eq '", m_barcode,"' and Active eq TRUE")
query <- URLencode(query)

mmd<- CoreAPIV2::apiGET(coreApi = creds,resource = resource, query = query,headers = headers,useVerbose = TRUE )





query <-paste0("?$filter=BB_PETMRK_SUBJECT eq '", f_barcode,"' and Active eq TRUE")
query <- URLencode(query)

fmd<- CoreAPIV2::apiGET(coreApi = creds,resource = resource, query = query,headers = headers,useVerbose = TRUE )


md  <- data.frame(subject =c("offspring","mother","father"),stringsAsFactors = FALSE)

md<- cbind(md,rbind(as.data.frame(osmd$content[[1]][17:38],stringsAsFactors = FALSE),
                    as.data.frame(mmd$content[[1]][17:38],stringsAsFactors = FALSE),
                    as.data.frame(fmd$content[[1]][17:38],stringsAsFactors = FALSE))
)
md <- as.data.frame(md,stringsAsFactors = FALSE)  

eval<-apply(md[,-1],2,marker_eval)

fr <- md

fr[4,] <- c("results",eval)

fr



}


# 
# 
# 
# library(CoreAPIV2)
# library(CoreAPI)
# 
# api <- CoreAPIV2::coreAPI("account-bb.json")
# 
# creds <- CoreAPIV2::authBasic(api)
# 
# creds <- creds$coreApi
# 
# os_barcode <- "PET0007"
# m_barcode <- "PET0041"
# 
# m_barcode <- "PET0551"
# f_barcode <- "PET0773"
# 
# all(fr[4,-1] == TRUE,na.rm = TRUE)
