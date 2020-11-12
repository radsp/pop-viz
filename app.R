library(shiny)
library(civis)

if(!require(leaflet)){
  install.packages("leaflet")
  }

if(!require(remotes)){
  install.packages("remotes")
  }
library(remotes)

if(!require(bslib)){
  remotes::install_github("rstudio/bslib")
  }

library(leaflet)
library(bslib)

source("dat-prep.R")
source("myUI.R")
source("myServer.R")


shinyApp(ui = ui, server = server)
