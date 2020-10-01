library(patchwork)
library(ggplot2)
plot_pal <- function(cols){
    pdata <- tibble(col = cols, x= seq(1, length(cols)), y=0)
    cv <- cols
    names(cv) <- cv
    plot <- ggplot(pdata) + 
        geom_tile(aes(x=x, y=y,fill = col), width = 1, height= .5) +
        scale_fill_manual(values=cv) +
        theme_void()+
        theme(legend.position = 'none')
    return(plot)
}