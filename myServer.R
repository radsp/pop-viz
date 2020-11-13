

server <- function(input, output, session) {
  
  observeEvent(input$main_page, {
    if (input$main_page %in% "Map") {
      showModal(modalDialog(
        title = "Key Analytic Questions",
        #div(id = "key_questions", style = "width: 250px; height: 100px;",
            HTML("<ol><li>What is the population?</li>
                 <li>Are there any residential structure?</li>
                 <li>Where are the health facilities located</li></ol>"),
        easyClose = TRUE, 
        footer = tagList(HTML('<p>Click <i class="far fa-lightbulb";></i>  to show this message again</p>'),
                         modalButton("Dismiss"))
      ))
    }
    
  })
  
  
  
  # Define inital view location ----------------------------------------------------------------
  lat0 <- 8
  lon0 <- 3.6
  z0 <- 9
  
  # Add tile paths as resources ----------------------------------------------------------------
  
  
  
  for(i in 1:nrow(df_bdry)){
    addResourcePath(as.character(df_bdry$tile[i]), as.character(df_bdry$tile_path[i]))
  }
  
  for(i in 1:3){
    addResourcePath(as.character(df_pop$tile[i]), as.character(df_pop$tile_path[i]))
  }
  
  for(i in 1:4){
    addResourcePath(as.character(df_lshd$tile[i]), as.character(df_lshd$tile_path[i]))
  }

  
  # Base map -------------------------------------------------------------------------------------
  
  output$out_map <- renderLeaflet({
    leaflet(options = leafletOptions(zoomControl = FALSE)) %>% 
      htmlwidgets::onRender("function(el, x) {
        L.control.zoom({ position: 'topright' }).addTo(this)}") %>% 
      setView(lon0, lat0, z0)  %>%
      addMapPane("background_map", zIndex = 190) %>%
      addMapPane("background_google", zIndex = 200) %>%
      addTiles(group = "OpenStreetMap", options = pathOptions(pane = "background_map")) %>%
      addTiles(urlTemplate = "https://mts1.google.com/vt/lyrs=y&hl=en&x={x}&y={y}&z={z}&s=Ga", 
               attribution = 'Google', group = "Satellite", options = pathOptions(pane = "background_map")) %>%
      addLayersControl(
        baseGroups = c("OpenStreetMap", "Satellite"),
        options = layersControlOptions(collapsed = FALSE), position = "bottomleft") %>%
      addScaleBar(position = "bottomright") %>%
      addTiles(urlTemplate ="/tile_pop_all/{z}/{x}/{y}.png", group = "group_pop", layerId = "lyr_pop_all") %>%
      addTiles(urlTemplate = "/tile_state/{z}/{x}/{y}.png", group = "group_bdry", layerId = "lyr_state") %>%
      onRender(
        "function(el,x){
                    this.on('mousemove', function(e) {
                        var lat = e.latlng.lat;
                        var lng = e.latlng.lng;
                        var coord = [lat, lng];
                        Shiny.onInputChange('hover_coordinates', coord)
                    });
                    this.on('mouseout', function(e) {
                        Shiny.onInputChange('hover_coordinates', null)
                    })
                }"
      ) %>%
      addControl(actionButton("open_key", NULL, icon = icon("lightbulb"),
                              style = "height: 20px; width: 20px; padding: 0; font-size: 130%"),
                 position = "topright", className = "info legend"
      ) %>%
      addControl(actionButton("go_home", NULL, icon = icon("home"), style = "height: 20px; width: 20px; padding: 0; font-size: 130%"), 
        position = "topright", className = "info legend") %>%
      addLegend("bottomright", colors = clr_pop, labels = label_pop, title = "Population<br>(per 900 sqm)",
                layerId = "legend_pop", opacity = 1)
      
  })
  
  
  output$llpos <- renderText({
    if (is.null(input$hover_coordinates)) {
      NULL
    } else {
      HTML(paste("Lat: ", format(round(input$hover_coordinates[1],5), nsmall = 5), 
            ", Lon: ", format(round(input$hover_coordinates[2],5), nsmall = 5), sep = ""))
    }
  })
  
  observeEvent(input$go_home, {
    leafletProxy("out_map") %>% setView(lon0, lat0, z0) 
  })
  
  observeEvent(input$open_key, {
    showModal(modalDialog(
      title = "Key Analytic Questions",
      #div(id = "key_questions", style = "width: 250px; height: 100px;",
      HTML("<ol><li>What is the population?</li>
                 <li>Are there any residential structure?</li>
                 <li>Where are the health facilities located</li></ol>"),
      easyClose = TRUE, 
      footer = tagList(HTML("<p>Click the lighbulb icon to show this message again</p>"),
                       modalButton("Dismiss"))
    ))
  })
  
  # Population map -----------------------------------------------------------------------------------
  
  
  observe({
    
    if (is.null(input$pop)) {
      in_pop <- 0
    } else {
      in_pop <- as.numeric(input$pop)
    }
    
    if(0 %in% in_pop){
      leafletProxy("out_map") %>%
        clearGroup(group = "group_pop") %>%
        removeControl(layerId = "legend_pop")
    } else {
      if(all(!df_pop$on)){
        leafletProxy("out_map") %>%
          addLegend("bottomright", colors = clr_pop, labels = label_pop, title = "Population<br>(per 900 sqm)",
                    layerId = "legend_pop", opacity = 1)
      }
      for (i in 1:nrow(df_pop)) {
        if ((i %in% in_pop) & (df_pop$on[i] == FALSE)) {
          urli <- paste("/", df_pop$tile[i], "/{z}/{x}/{y}.png", sep = "")
          leafletProxy("out_map") %>%
            addTiles(urlTemplate = urli, layerId = as.character(df_pop$id[i]), group = "group_pop") 
          df_pop$on[i] <- TRUE
        } else if ((i %in% in_pop) & (df_pop$on[i] == TRUE)) {
          next()
        } else {
          leafletProxy("out_map") %>%
            removeTiles(layerId = as.character(df_pop$id[i])) 
          df_pop$on <- FALSE
        }
      }
        
    }
    
  })
  
  
  
  # Residentials -----------------------------------------------------------------------------------
  
  observe({
    
    if (is.null(input$lshd)) {
      in_lshd <- 0
    } else {
      in_lshd <- as.numeric(input$lshd)
    }
    
    if (0 %in% in_lshd) {
      leafletProxy("out_map") %>%
        clearGroup(group = "group_lshd") %>%
        removeControl(layerId = "legend_lshd")
    } else {
      leafletProxy("out_map") %>%
        addLegendCustom(colors = df_lshd$clr[in_lshd],
                        sizes = 10, 
                        labels = lapply(as.character(df_lshd$legend_label[in_lshd]), htmltools::HTML),
                        shapes = "circle",
                        borders = df_lshd$clr[in_lshd],
                        opacity = 0.96,
                        layerId = "legend_lshd",
                        title = "Residential/Building")
      for (i in 1:4) {
        if ((i %in% in_lshd) & (df_lshd$on[i] == FALSE)) {
          urli <- paste("/", df_lshd$tile[i], "/{z}/{x}/{y}.png", sep = "")
          leafletProxy("out_map") %>%
            addTiles(urlTemplate = urli, layerId = as.character(df_lshd$id[i]), group = "group_lshd") 
          df_lshd$on[i] <- TRUE
        } else if ((i %in% in_lshd) & (df_lshd$on[i] == TRUE)) {
          next()
        } else {
          leafletProxy("out_map") %>%
            removeTiles(layerId = as.character(df_lshd$id[i])) %>%
            removeControl(layerId = as.character(df_lshd$legend_id[i]))
          df_lshd$on <- FALSE
        }
      }
    }
    
  })
  
  
  # Boundary map -----------------------------------------------------------------------------------
  
  observe({
    
    if (is.null(input$bdry)) {
      in_bdry <- 0
    } else {
      in_bdry <- as.numeric(input$bdry)
    }
  
    if (0 %in% in_bdry) {
      leafletProxy("out_map") %>%  # removeTiles(layerId = as.character(df_bdry$id))
        clearGroup(group = "group_bdry")
      df_bdry$on <- FALSE
    } else {
      for (i in 1:nrow(df_bdry)) {
        # Add if it is not on
        if ((i %in% in_bdry) & (df_bdry$on[i] == FALSE)) {
          urli <- paste("/", df_bdry$tile[i], "/{z}/{x}/{y}.png", sep = "")
          leafletProxy("out_map") %>% 
            addTiles(urlTemplate = urli, layerId = as.character(df_bdry$id[i]), group = "group_bdry")
          df_bdry$on[i] <- TRUE
        } else {
          leafletProxy("out_map") %>% 
            removeTiles(layerId = as.character(df_bdry$id[i]))
          df_bdry$on[i] <- FALSE
        }
      }
    }
    
  })
  
  
  # Health Facilities -----------------------------------------------------------------------------------
  
  
  observe({
    
    if (is.null(input$hfs)) {
      in_hfs <- 0
    } else {
      in_hfs <- as.numeric(input$hfs)
    }
    
    leafletProxy("out_map") %>%
      clearMarkers() %>%
      clearMarkerClusters()
    
    if(!(0 %in% in_hfs)){
      for(i in in_hfs){
        leafletProxy("out_map") %>%
          addAwesomeMarkers(data = eval(as.symbol(as.character(df_hfs$data[i]))),
                            lng = ~ longitude, lat = ~ latitude,
                            clusterOptions = markerClusterOptions(),
                            clusterId = as.character(df_hfs$id[i]),
                            icon = awesomeIcons(icon = df_hfs$icon[i], library = "fa",
                                                iconColor = "#ffffff", markerColor = df_hfs$color[i]),
                            popup = ~ lapply(as.character(txt), htmltools::HTML)
          )
      }
    }
    
  })

  
}

  

  
