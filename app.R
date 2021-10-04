install.packages("shiny")
install.packages("htmltools")
library(civis)
library(htmlwidgets)


# if(!require(bslib)){
#   install.packages("remotes")
#   remotes::install_github("rstudio/bslib")
#   library(bslib)
# }

# install.packages('bslib',repos='http://cran.us.r-project.org')
# library(bslib)

libs <- c("leaflet")
for (i in 1:length(libs)) {
  if(!require(libs[i], character.only = TRUE)){
    install.packages(libs[i])
    library(libs[i], character.only = TRUE)
  }
}

# source("dat-hf.R")
# source("dat-school.R")
source("get-mdive.R")

library(leaflet)


source("dat-prep.R")
source("myUI.R")
source("myServer.R")



shinyApp(ui = ui, server = server)
