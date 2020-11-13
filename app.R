library(shiny)
library(civis)
library(htmlwidgets)
library(htmltools)

if(!require(bslib)){
  install.packages("remotes")
  remotes::install_github("rstudio/bslib")
  library(bslib)
}


libs <- c("leaflet", "bslib")
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
