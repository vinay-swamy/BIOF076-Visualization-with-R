library(tidyverse)
library(shiny)

data <- read_tsv('src/pbmc_cell_expression.tsv.gz')
data_long <- data %>% pivot_longer(-colnames(data)[1:4], 
                          names_to ='gene',
                          values_to = 'exp')
ggplot(data_long) +
    geom_violin(aes(x=gene, y=exp, fill = gene )) +
    facet_wrap(~cell_type)+
    theme_minimal()

ui <- fluidPage(
    titlePanel(''),
    
       plotOutput(outputId = 'violinplot' ),
       radioButtons(inputId = 'radiobutton', 
                    label = 'Choose a column to plot', 
                    choices = c('cell_type', 'patient_id'),
                    selected ='cell_type' 
            ),
        plotlyOutput(outputId = 'pca')
    
)
server <- function(input, output) {
    output$violinplot <- renderPlot({
       ggplot(data_long) +
            geom_violin(aes(x=gene, y=exp, fill = gene )) +
            facet_wrap(input$radiobutton)+
            theme_minimal()
        
    })
    output$pca <- renderPlotly({
        pca_data <-  prcomp(data[,5:14])
        pca_x <- pca_data$x[,1:3] %>% as.data.frame
        colnames(pca_x) <- c('PC1', 'PC2', 'PC3')
        pca_df <- bind_cols(pca_x, data)
        # sum_pca <- summary(pca_data)
        # pc1_prop <- round(sum_pca$importance[2, 1], digits = 2)*100
        # pc2_prop <- round(sum_pca$importance[2, 2], digits = 2)*100
        # plot <- ggplot(pca_df) + 
        #     geom_point(aes(x=PC1, y=PC2, color = cell_type)) + 
        #     xlab(paste0('PC1 (', pc1_prop,  ' percent of variance explained)') )+
        #     ylab(paste0('PC2 (', pc2_prop,  ' percent of variance explained)') )+
        #     guides(color = guide_legend(title = 'Cell Type')) + 
        #     ggtitle('PCA generated from selected genes')+
        #     theme_minimal()
        
        plot_ly(pca_df,x= ~PC1, y= ~PC2, z= ~PC3, color = ~cell_type)
        #ggplotly(plot)
        
    })
    
}

shinyApp(ui = ui, server = server)







