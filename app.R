library(shiny)
library(leaflet)
library(bootstraplib)
library(civis)

# source("dat-prep.R")
source("myUI.R")
source("myServer.R")


shinyApp(ui = ui, server = server)