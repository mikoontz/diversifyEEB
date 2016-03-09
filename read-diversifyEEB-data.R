library(googlesheets)
library(lubridate)

keyString <- "1XsnX7WXgUzGEA-1zisZC29KSFrSXKzcbakIkp1nSues"

dEEBkey <- gs_key(keyString)

dEEB <- gs_read(dEEBkey)
head(dEEB)
colnames(dEEB) <- c("Timestamp", "Name", "Affiliation", "Email", "Website", "Twitter", "Current_Career_Stage", "Field", "Subfield", "Subfield_Keyword1", "Subfield_Keyword2", "Country", "Underrepresented_racial_ethnic_minority_status", "Person_with_disability", "Other_underrepresented_group", "Elaborate")

head(dEEB)
dEEB$Timestamp <- mdy_hms(dEEB$Timestamp)
dEEB$Twitter[!is.na(dEEB$Twitter) & substr(dEEB$Twitter, 1, 1) != "@"] <- paste0("@", dEEB$Twitter[!is.na(dEEB$Twitter) & substr(dEEB$Twitter, 1, 1) != "@"])

dEEB[grep(" ", dEEB$Twitter), c("Name", "Twitter")]
