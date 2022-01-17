#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggiraph)
library(plotly)
library(tidyverse)
# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            sliderInput("bins",
                        "Number of bins:",
                        min = 1,
                        max = 50,
                        value = 30)
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("scatterPlot"),
           selectInput(inputId = 'table_selecter',
                       label = 'Select an Input ',
                       choices = c("setosa", "versicolor", "virginica" ),
                       selected = "virginica"),
           
           selectInput(inputId = 'color_selecter', 
                       label = 'Select a column to color on',
                       choices = c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width", "Species"),
                       selected = "Sepal.Length"
                       ),
           plotlyOutput(outputId = "table_output")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    observeEvent(input$table_selecter,{
        plot_data <- iris %>% 
            filter(Species == input$table_selecter)
        output$scatterPlot <- renderPlotly({
            
            plot <- ggplot(plot_data) + 
                geom_point(aes(x=Sepal.Length, y=Sepal.Width, 
                                           color = !!as.symbol(input$color_selecter), 
                                           ) ) + 
                theme_minimal()
            plot %>% ggplotly
        })
        
        output$table_output <- renderTable({
            plot_data
        })
        
    } )

}

# Run the application 
shinyApp(ui = ui, server = server)
