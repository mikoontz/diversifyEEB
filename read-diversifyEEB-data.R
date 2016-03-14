load_andor_install <- function(pkg)
{
  if (!suppressWarnings(require(pkg, character.only = TRUE)))
  {
    install.packages(pkg)
    library(pkg, character.only = TRUE)
  }
  paste0(pkg, " loaded.")
}

required_packages <- c("googlesheets", "lubridate")
lapply(required_packages, load_andor_install)

keyString <- "1XsnX7WXgUzGEA-1zisZC29KSFrSXKzcbakIkp1nSues"

eebkey <- gs_key(keyString)
eeb <- gs_read(eebkey)
eeb <- as.data.frame(eeb)

colnames(eeb) <- c("Timestamp", 
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
eeb$Timestamp <- mdy_hms(eeb$Timestamp)

# Add an @ symbol to Twitter handles that do not start with one
eeb$Twitter[!is.na(eeb$Twitter) & substr(eeb$Twitter, 1, 1) != "@"] <-
  paste0("@", eeb$Twitter[!is.na(eeb$Twitter) & substr(eeb$Twitter, 1, 1) != "@"])

# Remove spaces (usually trailing spaces) from twitter handles
eeb$Twitter <- 
  gsub("\\s", "", eeb$Twitter)

tweeps <- paste(eeb$Twitter[!is.na(eeb$Twitter)], collapse=", ")
# write.table(tweeps, "tweeps.txt", row.names= FALSE, col.names= FALSE, quote= FALSE)
