library(rtweet)
library(rvest)
library(polite)
library(dplyr)

# NOAA Collection

#bookSource <- c("NOAA Photo Library")
#
#fishRange  <- (4322:4705)[-c(4512,4514,4555:4581)]
#fishURL    <- "https://photolib.noaa.gov/Collections/Historic-Fisheries/Natural-History-of-Useful-Aquatic-Animals/Fish/emodule/518/eitem/"
#fishURLs   <- paste0(fishURL,fishRange)
#
#mmRange <- 4288:4321
#mmURL   <- "https://photolib.noaa.gov/Collections/Historic-Fisheries/Natural-History-of-Useful-Aquatic-Animals/Marine-Mammals/emodule/517/eitem/"
#mmURLs  <- paste0(mmURL,mmRange)
#
#shellRange <- 4706:4731[-4713]
#shellURL   <- "https://photolib.noaa.gov/Collections/Historic-Fisheries/Natural-History-of-Useful-Aquatic-Animals/Shellfish-and-Miscellaneous-Sea-Creatures/emodule/516/eitem/"
#shellURLs  <- paste0(shellURL,shellRange)
#
#allURLs <- c( fishURLs, mmURLs, shellURLs )
#
#N <- length(allURLs)
#
#df <- data.frame( img=rep(NA,N), desc=rep(NA,N), source=rep(NA,N) )
#
#for( i in 1:N )
#{
#  if( i %% 10 == 0 )
#    print(paste(i,"/",N))
#
#  url <- allURLs[i]
#  
#  desc <- bow(url) %>%
#          scrape(content="text/html; charset=UTF-8") %>%
#          html_nodes(".edsgg_itemTitle") %>%
#          html_text()
#  
#  img <- bow(url) %>%
#         scrape(content="text/html; charset=UTF-8") %>%
#         html_nodes("img") %>%
#         html_attr("src") %>%
#         .[2] %>%
#         paste0( "https://photolib.noaa.gov", . )
#  
#  df[i,"img"]  <- img
#  df[i,"desc"] <- gsub("  "," ",desc)
#  df[i,"source"]  <- bookSource
#
#}
#
#write.csv( df, row.names=FALSE, file="noaaURLs.csv" )



df <- read.csv( file="noaaURLs.csv" ) %>%
      mutate( weight=3 )

# University of Washington Collection

uw <- read.csv("UW.csv",sep="|")

uwURL  <- paste0("https://digitalcollections.lib.washington.edu/digital/iiif/fishimages/",uw$img,"/full/full/0/default.jpg")

uwDF   <- data.frame(img=uwURL,
                     desc=uw$desc,
                     source="
University of Washington Digital Collections",
                     weight=3)

# Flickr collection

flickrURLS <- read.csv("flickrURLs.csv",sep="|")
flickrDF  <- data.frame( img=flickrURLS$img,
                         desc=flickrURLS$desc,
                         source="
Ernst Mayr Library, Flickr",
                          weight=1e10 )


# Canadian Great Lakes North Shore Fisheries Archive

nsfDF <- read.csv("nsfDF.csv") %>%
         mutate( weight=7 )

# Bella Coola Archives

bcDF <- read.csv("bellaCoolaDF.csv") %>%
        mutate( weight=7 )

# BC Regional Digitized History

bcrdhDF <- read.csv( file="bcrdhDF.csv" ) %>%
           mutate( weight=3 )

# Royal BC Museum

royalDF <- read.csv( file="royalBC.csv" ) %>%
           mutate( weight=3 )

# Thompson and Freeman - History of Halibut Fishery

halibutDF <- read.csv( file="halibutDF.csv" ) %>%
             mutate( weight=5 )   

# Fishbook

fishbookDF <- read.csv( file="fishbookDF.csv" ) %>%
              mutate( weight=12 )   

# Gyotaku book

gyotakuHiyamaDF <- read.csv( file="gyotakuHiyamaDF.csv" ) %>%
                   mutate( weight=12 ) 

# Gyotaku Flickr

gyotakuFlickrDF <- read.csv( file="gyotakuFlickrDF.csv" ) %>%
                   mutate( weight=1.5 )

# Poissons book

poissonsDF <- read.csv( file="poissonsDF.csv" ) %>%
              mutate( weight=1.5,
                      desc=source,
                      source=" " )

# Renard book

renardDF <- read.csv( file="renardDF.csv" ) %>%
              mutate( weight=2,
                      desc=source,
                      source=" " )

# Lapecede book

lapecedeDF <- read.csv( file="lapecedeDF.csv" ) %>%
              mutate( weight=5,
                      desc=source,
                      source=" " )

# Everything

df <- rbind( df,
             uwDF,
             flickrDF,
             nsfDF,
             bcDF,
             bcrdhDF,
             royalDF,
             halibutDF,
             fishbookDF,
             gyotakuHiyamaDF,
             gyotakuFlickrDF,
             poissonsDF,
             renardDF,
             lapecedeDF )

write.csv(df,file="URLs.csv",row.names=FALSE)




