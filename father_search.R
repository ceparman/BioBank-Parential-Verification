
creds <- CoreAPIV2::authBasic(api)

creds <- creds$coreApi

resource <- "TESTPETMARKER"


headers <- c('Content-Type' = "application/json;odata.metadata=minimal", accept = "application/json")

q<- list()

for(i in 1:ncol(mt))
{
  
q[[i]] <- build_m_marker_query(colnames(mt[i]),mt[1,i],mt[2,i])
  
}

query <- paste0("?$filter=", paste(q,collapse = " and "))
query <- URLencode(query)



r<- CoreAPIV2::apiGET(coreApi = creds,resource = resource, query = query,headers = headers,useVerbose = TRUE )
