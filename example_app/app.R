# Load packages
library(shiny)
library(plotly)
library(dplyr)
library(DT)
library(shinydashboard)

# Load functions and data from scripts in the R folder
source("R/get_data.R")
source("R/utils.R")

# Define UI - the UI (user interface) controls the layout and appearance 
# of your app (the front end)
ui <- dashboardPage(
  
  # Set colour theme for the app
  skin = "green",
  
  # Create header - set title of the app 
  dashboardHeader(title = "Penguins"),
  
  # Create sidebar
  dashboardSidebar(
    # Each menuItem is like a tab and will display different content in the main body
    sidebarMenu(
      menuItem("Adelie", tabName = "adelie"),
      menuItem("Gentoo", tabName = "gentoo"),
      menuItem("Chinstrap", tabName = "chinstrap"),
      # Inputs can also go in the sidebar
      # Create a dropdown input for the year, populated by the years in the dataset
      selectInput(
        inputId = "year", label = "Year", choices = unique(data$year)
      )
    )
  ),
  
  # Create main body 
  dashboardBody(
    # Create the contents of each sidebar tab
    tabItems(
      # Use the tabName of the relevant sidebar menuItem 
      tabItem(tabName = "adelie", 
              # Create a row on the page
              fluidRow(
                # Create value boxes (the full page width is 12)
                valueBoxOutput(outputId = "biscoe_box", 
                               width = 4),
                valueBoxOutput(outputId = "dream_box", 
                               width = 4),
                valueBoxOutput(outputId = "torgersen_box", 
                               width = 4)
              ),
              
              fluidRow(
                # Create a box with tabs to display different content
                tabBox(width = 12, 
                       # The first tab will display the plotly chart
                       tabPanel(title = "Chart",
                                plotlyOutput("plot")),
                       # The second tab will display the table
                       tabPanel(title = "Table",
                                dataTableOutput("table"),
                                downloadButton(outputId = "downloadData", 
                                               label = "Download"))
                       )
                )),
      # Second and third tabs for the other penguin species 
      tabItem(tabName = "gentoo"),
      tabItem(tabName = "chinstrap")
      )
    )
)

# Define server - this contains the instructions needed to build the app (the back end)
server <- function(input, output) {
  
  # Set the year for the whole page based on what is selected in the dropdown
  # this makes selected_year a reactive expression
  # so from here we reference it like a function: selected_year()
  # the input$year comes from the id we set in the ui function
  selected_year <- reactive({
    input$year
  })
  
  # Filter the dataset in a reactive expression too
  filtered_data <- reactive({
    data %>% filter(year == selected_year() & species == "Adelie")
  })
  
  # Generate a plot of the data for selected year
  # output$plot because we set the plotly output id to "plot" in the ui function
  output$plot <- renderPlotly({
    
    # Create plotly plot using a function created in R/utils.R
    bill_flipper_plot(filtered_data(), species = "Adelie")
    
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
  
  output$biscoe_box <- renderValueBox({
    valueBox(subtitle = "Biscoe",
             value = filtered_data() %>% filter(island == "Biscoe") %>% nrow(),
             color = "blue")
  })
  
  output$dream_box <- renderValueBox({
    valueBox(subtitle = "Dream",
             value = filtered_data() %>% filter(island == "Dream") %>% nrow(),
             color = "purple")
  })
 
  output$torgersen_box <- renderValueBox({
    valueBox(subtitle = "Torgersen",
             value = filtered_data() %>% filter(island == "Torgersen") %>% nrow(),
             color = "olive")
  })
  
}


# Run the application
shinyApp(ui = ui, server = server)
