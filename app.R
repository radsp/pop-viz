library(shiny)
library(civis)
library(htmlwidgets)
library(htmltools)

if(!require(bootstraplib)){
  install.packages("remotes")
  remotes::install_github("rstudio/bootstraplib")
  library(bootstraplib)
}

libs <- c("leaflet", "bootstraplib")
for (i in 1:length(libs)) {
  if(!require(libs[i], character.only = TRUE)){
    install.packages(libs[i])
    library(libs[i], character.only = TRUE)
  }
}

source("get-mdive.R")
source("dat-prep.R")
source("myUI.R")
source("myServer.R")


shinyApp(ui = ui, server = server)
