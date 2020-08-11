server <- function(input, output){
  
  addResourcePath("tileRes_popAll", "data_unpacked/fbpop-all")
  
  output$out_map <- renderLeaflet({
    leaflet() %>% 
      setView(8,9,7)  %>%
      addMapPane("background_map", zIndex = 190) %>%
      addMapPane("background_google", zIndex = 200) %>%
      addProviderTiles(providers$CartoDB.Voyager, group = "OpenStreetMap", options = pathOptions(pane = "background_map")) %>%
      addTiles(urlTemplate = "https://mts1.google.com/vt/lyrs=y&hl=en&x={x}&y={y}&z={z}&s=Ga", 
               attribution = 'Google', group = "Satellite", options = pathOptions(pane = "background_google")) %>%
      addLayersControl(
        overlayGroups = c("OpenStreetMap", "Satellite"),
        options = layersControlOptions(collapsed = FALSE), position = "topright") %>%
      hideGroup("Satellite") %>%
      addTiles(urlTemplate = "/tileRes_popAll/{z}/{x}/{y}.png")  
  })
}