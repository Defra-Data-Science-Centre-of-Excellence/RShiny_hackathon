# Load packages
library(shiny)
library(plotly)
library(dplyr)
library(DT)
library(shinydashboard)
library(reactable)
library(shinyfilter)
library(shinyWidgets)
library(datamods)

# Load functions and data from scripts in the R folder
source("R/get_data.R")
source("R/utils.R")

# Define UI - the UI (user interface) controls the layout and appearance 
# of your app (the front end)
ui <- dashboardPage(
  
  # Set colour theme for the app
  skin = "green",
  
  # Create header - set title of the app 
  dashboardHeader(title = "RShiny Template"),
  
  # Create sidebar
  dashboardSidebar(
    sidebarMenu(
      # add an image at the top of the sidebar - good place for a logo
      div(
        style = "margin:10px 40px 10px 40px;",
        img(
          src = "Images/DASH_logo_white.png",
          width = "148",
          height = "136"
        )
      ),
      # add a break between the image and menu
      br(),
      # Each menuItem is like a tab and will display different content in the main body
      # the tabName is like an ID for the page to refer to it later in the script
      menuItem("General Stats", tabName = "stats"),
      menuItem("Dataset", tabName = "dataset"),
      menuItem("About", tabName = "about")
    )
  ),
  
  # Create main body 
  dashboardBody(
    # this is a useful bit of html which freezes the header and sidebar on the page
    tags$script(HTML(
      "$('body').addClass('fixed');"
    )),
    # Create the contents of each sidebar tab
    tabItems(
      # Use the tabName of the relevant sidebar menuItem
      tabItem(
        tabName = "stats",
        # Create a row on the page
        fluidRow(
          # put content into a box - boxes can be used to split up the contents of the page
          box(
            # Create a dropdown input for the island, populated by the dataset
            selectInput(
              inputId = "island",
              label = "Island",
              choices = unique(data$island)
            )
          )),
        fluidRow(
          # Create value boxes (the full page width is 12)
          valueBoxOutput(outputId = "adelie_box",
                         width = 4),
          valueBoxOutput(outputId = "chinstrap_box",
                         width = 4),
          valueBoxOutput(outputId = "gentoo_box",
                         width = 4)
        ),
        
        fluidRow(
          # Create a box with tabs to display different content
          tabBox(
            width = 12,
            # The first tab will display the plotly chart
            tabPanel(title = "Chart",
                     plotlyOutput("plot")),
            # The second tab will display the table
            tabPanel(
              title = "Table",
              dataTableOutput("table"),
              downloadButton(outputId = "downloadData",
                             label = "Download")
            )
          ))
      ),
      # Tab for displaying and filtering the dataset
      tabItem(tabName = "dataset",
              fluidRow(
                box(title = "Apply filters",
                      # set up filters
                      select_group_ui(
                        id = "my-filters",
                        params = list(
                          species = list(inputId = "species",
                                         label = "Species"),
                          island = list(inputId = "island",
                                        label = "Island"),
                          sex = list(inputId = "sex",
                                     label = "Sex"),
                          year = list(inputId = "year",
                                      label = "Year")
                        )
                      ),
                    width = 12),
                # download button
                fluidRow(box(
                  title = "Download",
                  actionButton("Download", "Download data",
                               onClick = "Reactable.downloadDataCSV('data', 'penguins.csv')"),
                  width = 12
                )),
                # data table
                fluidRow(box(
                  title = "Penguins dataset",
                  reactableOutput(outputId = "tbl_penguins"),
                  width = 12
                ))
              )),
      # Tab for general information
      tabItem(tabName = "about",
              fluidRow(
                box(title = "About",
                    "Information about your app",
                    width = 12)
              ))
    ))
)

# Define server - this contains the instructions needed to build the app (the back end)
server <- function(input, output) {
  
  # Set the year for the whole page based on what is selected in the dropdown
  # this makes selected_year a reactive expression
  # so from here we reference it like a function: selected_year()
  # the input$year comes from the id we set in the ui function
  selected_island <- reactive({
    input$island
  })
  
  # Filter the dataset in a reactive expression too
  filtered_data <- reactive({
    data %>% filter(island == selected_island())
  })
  
  # Generate a plot of the data for selected year
  # output$plot because we set the plotly output id to "plot" in the ui function
  output$plot <- renderPlotly({
    
    # Create plotly plot using a function created in R/utils.R
    bill_flipper_plot(filtered_data())
    
  })
  
  # Generate a table of the filtered data using the DT package to get an interactive table
  output$table <- renderDataTable({
    datatable(filtered_data() %>% select(species, island, bill_length_mm, flipper_length_mm))
  })
  
  # Generate a download button to download a csv of the filtered data
  output$downloadData <- downloadHandler(
    filename = "data.csv",
    content = function(file) {
      write.csv(filtered_data(), file)
    }
  )
  
  # Generate the value boxes - set the values based on the filtered data 
  # and the appearance of the box
  
  output$adelie_box <- renderValueBox({
    valueBox(subtitle = "Adelie",
             value = filtered_data() %>% filter(species == "Adelie") %>% nrow(),
             color = "blue")
  })
  
  output$gentoo_box <- renderValueBox({
    valueBox(subtitle = "Gentoo",
             value = filtered_data() %>% filter(species == "Gentoo") %>% nrow(),
             color = "purple")
  })
 
  output$chinstrap_box <- renderValueBox({
    valueBox(subtitle = "Chinstrap",
             value = filtered_data() %>% filter(species == "Chinstrap") %>% nrow(),
             color = "olive")
  })
  
  # set up table with filters
  res_mod <- select_group_server(id = "my-filters",
                                 data = reactive(data),
                                 vars = reactive(
                                   c(
                                     "species",
                                     "island",
                                     "sex",
                                     "year"
                                   )
                                 ))
  
  # DASH register table
  output$tbl_penguins <- renderReactable({
    reactable(res_mod(),
              searchable = TRUE,
              highlight = TRUE)
  })
  
}


# Run the application
shinyApp(ui = ui, server = server)
