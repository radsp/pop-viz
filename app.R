library(shiny)
library(civis)

if(!require(leaflet)){
  install.packages("leaflet")
  }
if(!require(bootstraplib)){
  install.packages("bootstraplib")
  }

library(leaflet)
library(bootstraplib)

source("dat-prep.R")
source("myUI.R")
source("myServer.R")


shinyApp(ui = ui, server = server)
