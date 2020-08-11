library(shiny)
library(civis)

if(!require(leaflet)){
  install.packages("leaflet")
  }

if(!require(remotes)){
  install.packages("remotes")
  }
library(remotes)

if(!require(bootstraplib)){
  remotes::install_github("rstudio/bootstraplib")
  }

library(leaflet)
library(bootstraplib)

source("dat-prep.R")
source("myUI.R")
source("myServer.R")


shinyApp(ui = ui, server = server)
