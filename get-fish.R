library(rtweet)
library(rvest)
library(polite)
library(dplyr)

# NOAA Collection

bookSource <- c("NOAA Photo Library")

fishRange  <- (4322:4705)[-c(4512,4514,4555:4581)]
fishURL    <- "https://photolib.noaa.gov/Collections/Historic-Fisheries/Natural-History-of-Useful-Aquatic-Animals/Fish/emodule/518/eitem/"
fishURLs   <- paste0(fishURL,fishRange)

mmRange <- 4288:4321
mmURL   <- "https://photolib.noaa.gov/Collections/Historic-Fisheries/Natural-History-of-Useful-Aquatic-Animals/Marine-Mammals/emodule/517/eitem/"
mmURLs  <- paste0(mmURL,mmRange)

shellRange <- 4706:4731[-4713]
shellURL   <- "https://photolib.noaa.gov/Collections/Historic-Fisheries/Natural-History-of-Useful-Aquatic-Animals/Shellfish-and-Miscellaneous-Sea-Creatures/emodule/516/eitem/"
shellURLs  <- paste0(shellURL,shellRange)

allURLs <- c( fishURLs, mmURLs, shellURLs )

N <- length(allURLs)

df <- data.frame( img=rep(NA,N), desc=rep(NA,N), source=rep(NA,N) )

for( i in 1:N )
{
  if( i %% 10 == 0 )
    print(paste(i,"/",N))

  url <- allURLs[i]
  
  desc <- bow(url) %>%
          scrape(content="text/html; charset=UTF-8") %>%
          html_nodes(".edsgg_itemTitle") %>%
          html_text()
  
  img <- bow(url) %>%
         scrape(content="text/html; charset=UTF-8") %>%
         html_nodes("img") %>%
         html_attr("src") %>%
         .[2] %>%
         paste0( "https://photolib.noaa.gov", . )
  
  df[i,"img"]  <- img
  df[i,"desc"] <- gsub("  "," ",desc)
  df[i,"source"]  <- bookSource

}

write.csv( df, row.names=FALSE, file="noaaURLs.csv" )

# University of Washington Collection

uw <- read.csv("UW.csv",sep="|")

uwURL  <- paste0("https://digitalcollections.lib.washington.edu/digital/iiif/fishimages/",uw$img,"/full/full/0/default.jpg")

uwDF   <- data.frame(img=uwURL,
                     desc=uw$desc,
                     source=rep("UW Digital Collections"))

df <- rbind( df, uwDF )

write.csv(df,file="URLs.csv",row.names=FALSE)









