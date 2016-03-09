library(googlesheets)
library(lubridate)

keyString <- "1XsnX7WXgUzGEA-1zisZC29KSFrSXKzcbakIkp1nSues"

dEEBkey <- gs_key(keyString)

dEEB <- gs_read(dEEBkey)
head(dEEB)
colnames(dEEB)
