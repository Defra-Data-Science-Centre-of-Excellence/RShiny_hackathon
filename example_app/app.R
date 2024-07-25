# load packages
library(shiny)
library(plotly)
library(dplyr)
library(DT)
library(shinydashboard)

source("R/get_data.R")
source("R/utils.R")

# Define UI - the UI (user interface) controls the layout and appearance 
# of your app (the front end)
ui <- dashboardPage(
  skin = "green",
  dashboardHeader(title = "Penguins"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Adelie", tabName = "adelie"),
      menuItem("Gentoo", tabName = "gentoo"),
      menuItem("Chinstrap", tabName = "chinstrap"),
      selectInput(
        "year", label = "Year", choices = unique(data$year)
      )
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "adelie",
              fluidRow(
                valueBoxOutput("biscoe_box", width = 4),
                valueBoxOutput("dream_box", width = 4),
                valueBoxOutput("torgersen_box", width = 4)
              ),
              fluidRow(
                box(title = "Comparison of Bill and Flipper length",
                    width = 12, 
                    plotlyOutput("plot"))
                )),
      tabItem(tabName = "gentoo"),
      tabItem(tabName = "chinstrap")
      )
    )
)

server <- function(input, output) {
  # set the year for the whole page based on what is selected in the dropdown
  # this makes selected_year a reactive expression
  # so from here we reference it like a function: selected_year()
  # the input$year comes from the id we set in the ui function
  selected_year <- reactive({
    input$year
  })
  
  filtered_data <- reactive({
    data %>% filter(year == selected_year() & species == "Adelie")
  })
  
  # generate a plot of the data for selected year
  # output$plot because we set the plotly output id to "plot" in the ui function
  output$plot <- renderPlotly({
    
    # create plotly plot using a function created in R/utils.R
    bill_flipper_plot(filtered_data(), species = "Adelie")
    
  })
  
  output$biscoe_box <- renderValueBox({
    valueBox("Biscoe",
             value = filtered_data() %>% filter(island == "Biscoe") %>% nrow(),
             color = "blue")
  })
  
  output$dream_box <- renderValueBox({
    valueBox("Dream",
             value = filtered_data() %>% filter(island == "Dream") %>% nrow(),
             color = "purple")
  })
 
  output$torgersen_box <- renderValueBox({
    valueBox("Torgersen",
             value = filtered_data() %>% filter(island == "Torgersen") %>% nrow(),
             color = "olive")
  })
  
}


# Run the application
shinyApp(ui = ui, server = server)
