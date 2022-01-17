#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(tidyverse)
library(DT)
# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Example Iris app "),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            DTOutput(outputId = 'table1')
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("iris_scatter"),
           selectInput(inputId = 'species_selector', 
                       label = 'Pick a Species', 
                       choices = c("setosa","versicolor","virginica" )),
           sliderInput(inputId = 'point_size', 
                       label = 'pick a point size', 
                       min=1, 
                       max = 10,
                       value =1 )
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$iris_scatter <- renderPlot({
        # generate bins based on input$bins from ui.R
       
        iris_filterd <- filter(iris, Species == input$species_selector)
        ggplot(iris_filterd) + 
            geom_point(aes(x=Petal.Length, y=Petal.Width), size = input$point_size)
    })
    
    output$table1 <- renderDT({
        datatable(iris)
        
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
