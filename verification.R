

library(CoreAPIV2)
library(CoreAPI)

api <- CoreAPIV2::coreAPI("account-bb.json")

creds <- CoreAPIV2::authBasic(api)

creds <- creds$coreApi


os <- CoreAPIV2::getEntityByBarcode(creds,"PET","PET0007")

os_barcode = "PET0101"
resource <- "PET"
query <- paste0("('",os_barcode,"')?$expand=PET_MOTHER,PET_FATHER")


headers <- c('Content-Type' = "application/json;odata.metadata=full", accept = "application/json")

eos <- apiGET(coreApi = creds,resource = resource, query = query,headers = headers,useVerbose = TRUE )




#get marker data



resource <- "TESTPETMARKER"

query <-paste0("?$filter=BB_PETMRK_SUBJECT eq '", os_barcode,"' and Active eq TRUE")
query <- URLencode(query)

headers <- c('Content-Type' = "application/json;odata.metadata=minimal", accept = "application/json")

osmd<- CoreAPIV2::apiGET(coreApi = creds,resource = resource, query = query,headers = headers,useVerbose = TRUE )


query <-paste0("?$filter=BB_PETMRK_SUBJECT eq '", eos$content$PET_MOTHER$Barcode,"' and Active eq TRUE")
query <- URLencode(query)

mmd<- CoreAPIV2::apiGET(coreApi = creds,resource = resource, query = query,headers = headers,useVerbose = TRUE )





query <-paste0("?$filter=BB_PETMRK_SUBJECT eq '", eos$content$PET_FATHER$Barcode,"' and Active eq TRUE")
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



