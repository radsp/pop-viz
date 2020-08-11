bs_theme_new(version = "4+3", bootswatch = "lux")


ui <- navbarPage(title = HTML("POPMAP &nbsp;&nbsp;&nbsp;&nbsp;"), inverse = TRUE,

                 # tags$nav(class="navbar navbar-expand-lg navbar-dark bg-primary"),

                 tabPanel("About",
                          bootstrap(),
                          p("The POPMAP dashboard is a tool to visualize high resolution population and building footprint ...."),
                          p("Available only for Oyo State, Nigeria"),
                          p("List data sources here")),
                 tabPanel("Map",
                          # # mainPanel(
                          #   fluidPage(
                          #     div(
                          #         tags$head(
                          #           includeCSS("www/panel_style.css")
                          #         ),
                          #         leafletOutput("out_map"),
                          #         absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE,
                          #                       draggable = TRUE, top = 60, left = "auto", right = 20, bottom = "auto",
                          #                       width = 330, height = "auto",
                          #                       h2("My Control"),
                          #                       selectInput(inputId = "in1", label = "Options:", choices = c("option 1", "option 2")))
                          #     ) ) #)
                          
                          
                          tags$style(type = "text/css", "#out_map {height: calc(100vh - 80px) !important;}",
                                     HTML(".main-sidebar { font-size: 17px; }")),
                          # tags$style(type = "text/css", ".box-body {width:80vh}"),
                          leafletOutput("out_map") 
                          
                          
                           )
                 )

