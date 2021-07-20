library(shiny)
# Define UI for app that draws a histogram ----
ui <- fluidPage(
    # App title ----
    titlePanel("Hello Shiny!"),
    # Sidebar layout with input and output definitions ----
    sidebarLayout(
        # Sidebar panel for inputs ----
        sidebarPanel(
            # Input: Slider for the number of bins ----
            sliderInput(inputId = "bin_output", label = "Number of bins:", min = 1,max = 50, value = 30)
        ),
        # Main panel for displaying outputs ----
        mainPanel(
            # Output: Histogram ----
            plotOutput(outputId = "hist_out")
        )
    )
)
server <- function(input, output) {
    output$hist_out <- renderPlot({ 
        x    <- faithful$waiting
        bins <- seq(min(x), max(x), length.out = input$bin_output + 1)
        
        hist(x, breaks = bins, col = "#75AADB", border = "white",
             xlab = "Waiting time to next eruption (in mins)",
             main = "Histogram of waiting times")
        
    })
    
}

shinyApp(ui = ui, server = server)

