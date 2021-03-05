library(shiny)
library(tidyverse)
library(DT)

ui <- fluidPage(
    titlePanel('Example Shiny App'),
    column(5,
          dataTableOutput(outputId = 'table'),    
        
    ),
    column(2),
    column(5,
        actionButton(inputId = 'plot_button',label = 'Draw Plot' ),
        plotOutput(outputId = 'scatter'),
        selectizeInput(inputId = 'flower_to_plot', 
                    label = 'Pick a flower to visualiz', 
                    selected = "setosa", choices = c("setosa", "versicolor",  "virginica")),
        sliderInput(inputId = 'point_size', label = "Choose a point size", 
                    value = 3, min = 1, max = 10)
    )
    
)

server <- function(input, output) {
   
    observeEvent(input$plot_button, {
        output$scatter <- renderPlot({
            data_to_plot <- iris %>%
                filter(Species == input$flower_to_plot)
            ggplot(data= data_to_plot) +
                geom_point(aes(x=Petal.Width, y= Petal.Length), size = input$point_size) +
                theme_minimal()
        })
    })
    
    
    output$table <- renderDataTable({
        data_to_plot <- iris %>%
            filter(Species == input$flower_to_plot)
        datatable(data_to_plot)
        
    })
}

shinyApp(ui = ui, server = server)
# flower_to_select <- 'setosa'
# data_to_plot <- iris %>% 
#     filter(Species == flower_to_select)
# ggplot(data= iris) + 
#     geom_point(aes(x=Petal.Width, y= Petal.Length)) + 
#     theme_minimal()
# 
# 
# View(iris)
