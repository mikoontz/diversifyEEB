load_andor_install <- function(pkg)
{
  if (!suppressWarnings(require(pkg, character.only = TRUE)))
  {
    install.packages(pkg)
    library(pkg, character.only = TRUE)
  }
  paste0(pkg, " loaded.")
}

required_packages <- c("googlesheets", "lubridate", "stringi")
lapply(required_packages, load_andor_install)

keyString <- "1XsnX7WXgUzGEA-1zisZC29KSFrSXKzcbakIkp1nSues"

dEEBkey <- gs_key(keyString)
dEEB <- gs_read(dEEBkey)
dEEB <- as.data.frame(dEEB)

colnames(dEEB) <- c("Timestamp", 
                    "Name", 
                    "Affiliation", 
                    "Email", 
                    "Website", 
                    "Twitter", 
                    "Current_Career_Stage", 
                    "Field", 
                    "Subfield", 
                    "Subfield_Keyword1", 
                    "Subfield_Keyword2", 
                    "Country", 
                    "Underrepresented_racial_ethnic_minority_status", 
                    "Person_with_disability", 
                    "Other_underrepresented_group", 
                    "Elaborate")

# Convert timestamp to POSIXct objects
dEEB$Timestamp <- mdy_hms(dEEB$Timestamp)

# Add an @ symbol to Twitter handles that do not start with one
dEEB$Twitter[!is.na(dEEB$Twitter) & substr(dEEB$Twitter, 1, 1) != "@"] <- paste0("@", dEEB$Twitter[!is.na(dEEB$Twitter) & substr(dEEB$Twitter, 1, 1) != "@"])

# Remove spaces from twitter handles
dEEB[grep(" ", dEEB$Twitter), "Twitter"] <- gsub("\\s", "", dEEB[grep(" ", dEEB$Twitter), "Twitter"])