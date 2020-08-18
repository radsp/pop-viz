bs_theme_new(version = "4+3", bootswatch = "lux")


ui <- fluidPage(br(),
                navbarPage(id = "main_page", title = HTML("POPMAP &nbsp;&nbsp;&nbsp;&nbsp;"), inverse = TRUE,

                 # tags$nav(class="navbar navbar-expand-lg navbar-dark bg-primary"),

                 tabPanel("About", tabName = "tab_about",
                          bootstrap(),
                          includeHTML("about.HTML"),
                          # p("The POPMAP dashboard is a tool to visualize high resolution population and building footprint ...."),
                          # p("Available only for Oyo State, Nigeria"),
                          # p("List data sources here")
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
                                            checkboxGroupInput(inputId = "hf", label = h6("Health Facilities"), choiceNames = c("Primary, Secondary & Tertiary (GRID3)"),
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


