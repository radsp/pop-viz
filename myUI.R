bs_theme_new(version = "4+3", bootswatch = "lux")


ui <- fluidPage(br(),
                navbarPage(id = "main_page", title = HTML("POPMAP &nbsp;&nbsp;&nbsp;&nbsp;"), inverse = TRUE,

                 # tags$nav(class="navbar navbar-expand-lg navbar-dark bg-primary"),

                 tabPanel("About", tabName = "tab_about",
                          bootstrap(),
                          # includeHTML("about.HTML"),
                          # p("The POPMAP dashboard is a tool to visualize high resolution population and building footprint ...."),
                          # p("Available only for Oyo State, Nigeria"),
                          # p("List data sources here")
                          HTML("<p>This dashboard provides a visualization of high-resolution population density (30-meter) and residential areas (90-meter) based on satellite imageries. The map is currently available for Oyo State, Nigeria. 
</p>
  <p> Visualization in this dashboard aims to answer the following key analytical questions:
  <ol>
  <li>What is the population?</li>
  <li>Are there any residential structures?</li>
  <li>Where are the health facilities located?</li></ol>
  </ol>
  </p>
  
  Note that since this visualization uses data from different sources with different spatial resolutions, there could be discrepancies when overlaying the datasets. 

Datasets included in this dashboard:
  
  <ul>
  <li><b>Population density</b> data was retrieved from Facebook Connectivity Lab and Center for International Earth Science Information Network (CIESIN) - Columbia University. In this dashboard, population density is available for children under 5 years age, women of reproductive age (15 - 49 years) and total population. The map was last updated in April 2019. Data has 30-meter resolution and is available through the Humanitaria Data Exchange. </li>
  <li><b>Residential area</b> data was developed by the Oak Ridge National Lab (ORNL) that was released in April 2018. Below are the layers that are included in the dashboard and their definition:
  <ul>
  <li>Hamlets: A single family compound or several (less than ten) compounds or 15 sleeping houses in isolation from small settlements or urban areas.</li>
  <li>Small Settlements (SS): A settled area of permanently inhabited structures and compounds of roughly a few hundred to a few thousand inhabitants, or 15 – 100 structures.  The housing pattern in SSs is an assemblage of family compounds adjoining other similar habitations.</li>
  <li>Built-up Areas: An area of urbanization, with moderately to densely spaced buildings, and a visible grid of streets and blocks. The Built-up Area typically may show a dense, vertically built urban core, with reduced density of habitations toward the outer margins. Buildings typically include significant areas of mixed land-use with residential, commercial, industrial, and government or academic campuses present.  Smaller built-up areas resemble rural village areas with  light to moderate settled concentration of  huts and structures which qualify for collection as an area due to overall size, number of huts and roofed structures within the enclosed limits or extent of the village.
</li>
  </ul>
  <li><b>Health Facilities</b> data was obtained from  Nigeria Health Facility Registry (HFR). Only those facilities that are in operational status and have complete latitude and longitude information are included here. </li>
  </ul>
     ")
                          ),
                 
                 tabPanel("Map", tabName = "tab_map",
                          tags$style(type = "text/css", "#out_map {height: calc(90vh - 80px) !important;}",
                                     HTML(".main-sidebar { font-size: 17px; }")),
                          # tags$style(type = "text/css", ".box-body {width:80vh}"),
                          leafletOutput("out_map"),
                          div(tags$head(includeCSS("www/panel_style.css")),
                              absolutePanel(id = "controls", class = "panel panel-default", 
                                            draggable = TRUE, top = "16%", left = "4%", right = "auto", bottom = "auto", width = 300, height = "auto",
                                            h5("Map Layers"),
                                            br(),
                                            checkboxGroupInput(inputId = "pop", label = h6("Population"), 
                                                               choiceName = c("All ages", "Children under 5 years", "Women of reproductive ages (15-49)"),
                                                               choiceValues = 1:3,
                                                              selected = 1),
                                            # tooltip("pop", "Population data from Facebook (30-meter resolution)"),
                                            checkboxGroupInput(inputId = "lshd", label = h6("Residentials/Buildings"), 
                                                               choiceNames = c("Hamlets", "Small Settlements Areas", "Settlements", "Built-up Areas", "Building Pattern"),
                                                               choiceValues = 1:5, selected = NULL),
                                            # tooltip("lshd", "Enter definition of all data"),
                                            checkboxGroupInput(inputId = "hf", label = h6("Health Facilities"), choiceNames = c("Primary, Secondary & Tertiary"),
                                                               choiceValues = 1, selected = NULL),
                                            checkboxGroupInput(inputId = "bdry", label = h6("Administrative Boundary"), choiceNames = c("State", "LGA", "Ward"),
                                                               choiceValues = c(1, 2, 3),
                                                               selected = 1)
                                            ),
                              absolutePanel(id = "boxll", #tags$head(tags$style(HTML("#llpos{text-align:center;}"))),
                                            draggable = FALSE, top = "auto", bottom = "5%", left = "45%", right = "auto", width = 250, height = "auto",
                                            verbatimTextOutput("llpos"))
                              )
                           )
                 )
                )


