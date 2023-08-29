sourceCode <- readLines("nsf-url.txt")

sourceCode <- sourceCode[ grepl( "jpg", sourceCode )]

sourceCode <- gsub(".*href=",'',sourceCode) %>%
							substr(2,nchar(sourceCode))

sourceCode <- gsub("\\.jpg.*","",sourceCode) %>%
							paste0( ".jpg" )

desc <- readLines("nsf-desc.txt")

nsfDF <- data.frame( img=sourceCode, desc=desc, source="Canadian Great Lakes North Shore Fisheries Archive" )

write.csv(nsfDF,file="nsfDF.csv",row.names=FALSE)