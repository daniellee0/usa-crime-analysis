# Redundant Code here
library("shiny") 
library("ggplot2")
library('dplyr')
library('plyr')
library('maps')
library('shinythemes')
library('reshape2')

server <- function(input, output) {
  # Redudant Code Here
  
  
  
  
  #############
  #### Home ###
  #############
  
  
  
  
  ##############
  ### Part 1 ###
  ##############
  
  
  
  
  
  ##############
  ### Part 2 ###
  ##############
  
  
  
  
  
  ##############
  ### Part 3 ###
  ##############
  
  
  
  
  
  
  ##############
  ### Part 4 ###
  ##############
  # read in the hate crime data from 2005-2016
  source("data/hate-crime-data.R")
  
  # filter the data by category, flip rows and columns and melt the data frame
  # in order to plot line graph
  filtered <- reactive({
    table <- hatecrime[hatecrime$Category == input$category, c("Bias.motivation", 2005:2016)]
    hatecrime.data <- data.frame(t(table[-1]))
    colnames(hatecrime.data) <- table[, 1]
    hatecrime.data$year <- rownames(hatecrime.data)
    melted <- melt(hatecrime.data, id.vars = "year")
    return(melted)
  })
  
    # create the line graph 
    output$hatecrime <- renderPlot({
    ggplot(data = filtered(), aes(x = year, y = value, group = variable)) +
        geom_line() +
        geom_point() +
        geom_line(aes(color = variable)) +
        geom_point(aes(color = variable)) +
      scale_color_brewer(palette = "Set1")
      })

}


shinyServer(server)