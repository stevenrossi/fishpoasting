library(rvest)
library(polite)
library(dplyr)

# NOAA Collection

# Historic Fisheries Research and Research Vessels, id=3392, N=76
# Natural History of Useful Aquatic Animals, id=4199, N=444
# History and Methods of Fisheries, id=3585, N=253


bookSource <- c("NOAA Photo Library")

noaaRange  <- 0:75
noaaURL    <- "https://www.noaa.gov/digital-library/collections/3392/item?page="
noaaURLs   <- paste0(noaaURL,noaaRange)

N <- length(noaaURLs)

df <- data.frame( img=rep(NA,N), desc=rep(NA,N), source=rep(NA,N) )

for( i in 1:N )
{
	print(i)
  #if( i %% 10 == 0 )
    #print( paste( i, "of", N ) )

  url <- noaaURLs[i]
  
  desc <- read_html(url) %>%
          html_elements(".c-field__item") %>%
          .[6] %>%
          html_text()
  
  img <- read_html(url) %>%
  			 #bow(url) %>%
         #scrape(content="text/html; charset=UTF-8") %>%
         html_nodes("img") %>%
         html_attr("src") %>%
         .[6] %>%
         paste0( "https://www.noaa.gov", . )

  #df[i,"img"]  <- img
  #df[i,"desc"] <- gsub("  "," ",desc)
  #df[i,"source"]  <- bookSource

  cat( paste0( '"', img, '","', desc, '","', bookSource, '"\n' ), file="noaaURLs-historicFisheries.csv", append=TRUE )

}

#write.csv( df, row.names=FALSE, file="noaaURLs.csv" )
