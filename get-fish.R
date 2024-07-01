#library(rtweet)
library(rvest)
library(polite)
library(dplyr)

# NOAA Collection

noaa1 <- read.csv( file="noaaURLs-historicFisheriesResearch.csv" )
noaa2 <- read.csv( file="noaaURLs-historyMethods.csv" )
noaa3 <- read.csv( file="noaaURLs-naturalHistory.csv" )
noaa4 <- read.csv( file="noaaURLs-historicFisheries.csv" )

noaaDF <- rbind( noaa1, noaa2, noaa3, noaa4 ) %>%
          mutate( weight=3 )

# National Archives
nfDF <- read.csv("urls/nationalArchivesDF.csv") %>%
        mutate( weight=2e10 )  

# University of Washington Collection

uw    <- read.csv("urls/UW.csv",sep="|")
uwURL <- paste0("https://digitalcollections.lib.washington.edu/digital/iiif/fishimages/",uw$img,"/full/full/0/default.jpg")
uwDF  <- data.frame(img=uwURL,
                    desc=uw$desc,
                    source="
University of Washington Digital Collections",
                    weight=3)

# Flickr collection

flickrURLS <- read.csv("urls/flickrURLs.csv",sep="|")
flickrDF  <- data.frame( img=flickrURLS$img,
                         desc=flickrURLS$desc,
                         source="
Ernst Mayr Library, Flickr",
                         weight=1 )


# Canadian Great Lakes North Shore Fisheries Archive

nsfDF <- read.csv("urls/nsfDF.csv") %>%
         mutate( weight=5 )

# Bella Coola Archives

bcDF <- read.csv("urls/bellaCoolaDF.csv") %>%
        mutate( weight=5 )

# BC Regional Digitized History

bcrdhDF <- read.csv( file="urls/bcrdhDF.csv" ) %>%
           mutate( weight=3 )

# Royal BC Museum

royalDF <- read.csv( file="urls/royalBC.csv" ) %>%
           mutate( weight=1 )

# Thompson and Freeman - History of Halibut Fishery

halibutDF <- read.csv( file="urls/halibutDF.csv" ) %>%
             mutate( weight=1 )   

# Fishbook

fishbookDF <- read.csv( file="urls/fishbookDF.csv" ) %>%
              mutate( weight=8 )   

# Gyotaku book

gyotakuHiyamaDF <- read.csv( file="urls/gyotakuHiyamaDF.csv" ) %>%
                   mutate( weight=12 ) 

# Gyotaku Flickr

gyotakuFlickrDF <- read.csv( file="urls/gyotakuFlickrDF.csv" ) %>%
                   mutate( weight=2 )

# Poissons book

poissonsDF <- read.csv( file="urls/poissonsDF.csv" ) %>%
              mutate( weight=4,
                      desc=source,
                      source=" " )

# Renard book

renardDF <- read.csv( file="urls/renardDF.csv" ) %>%
              mutate( weight=5,
                      desc=source,
                      source=" " )

# Lapecede book

lapecedeDF <- read.csv( file="urls/lapecedeDF.csv" ) %>%
              mutate( weight=8,
                      desc=source,
                      source=" " )

# Kissling book

kisslingDF <- read.csv( file="urls/kisslingDF.csv" ) %>%
              mutate( weight=20 )

# Arcturus book

arcturusDF <- read.csv( file="urls/arcturusDF.csv" ) %>%
              mutate( weight=1.5,
                      source="Arcturus Adventure (1926)" )

# Zoologica

zoologicaDF <- read.csv( file="urls/zoologicaDF.csv" ) %>%
               mutate( weight=2 )

# Hiroshige paintings

hiroshigeDF <- read.csv( file="urls/hiroshigeDF.csv" ) %>%
               mutate( weight=6 )

# Other

otherDF <- read.csv( file="urls/otherDF.csv" ) %>%
           mutate( weight=3 )

# Everything

df <- rbind( noaaDF,
             nfDF,
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
             lapecedeDF,
             kisslingDF,
             arcturusDF,
             zoologicaDF,
             hiroshigeDF,
             otherDF )

write.csv(df,file="urls/URLs.csv",row.names=FALSE)




