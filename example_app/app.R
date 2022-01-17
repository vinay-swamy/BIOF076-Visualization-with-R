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
setwd('/Users/vinayswamy/personal/BIOF076-Visualization-with-R/')
sc_data <- read_tsv('src/pbmc_cell_expression.tsv.gz') 
sc_Data_long <-  sc_data %>% pivot_longer(cols = -c(barcode,cell_type,cell_type_relabeled, patient_id), 
                                       names_to = 'gene_name', 
                                       values_to = 'expression')

# For UI:
#     - selectizeInput  for gene_ names 
#     - selectizeInput  for cell_types
#     - plotOutput()
# For server
#     - filter down input to selected genes and cell type_sum
#         -  use %in%, 
#     - renderPlot()

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Old Faithful Geyser Data"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            selectizeInput(inputId = 'cell_type_selecter', 
                           label = 'Select a Cell Type', 
                           choices = unique(sc_Data_long$cell_type), 
                           selected = c( "Memory CD4 T", "B"), 
                           multiple = T),
            selectizeInput(inputId = 'gene_name_selecter', 
                           label = 'Select a Gene name', 
                           choices = unique(sc_Data_long$gene_name), 
                           selected = c( "PPBP", "LYZ"), 
                           multiple = T)
    
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("dotPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    output$dotPlot <- renderPlot({
        plot_data <- sc_Data_long %>% 
            filter(cell_type %in% input$cell_type_selecter, 
                   gene_name %in% input$gene_name_selecter) %>% 
            mutate(is_expressed = expression > 0) %>% 
            group_by(cell_type, gene_name) %>% 
            summarise(`percent expressed` =sum(is_expressed) / n() * 100,
                      `avg expression` = mean(expression)) 
        ggplot(plot_data) + 
            geom_point(aes(x=gene_name, y=cell_type, size =`percent expressed`, color = `avg expression`)) + 
            theme_classic()
        
        
    })
    
}

# Run the application 
shinyApp(ui = ui, server = server)
