# Redundant Code here
library(dplyr)
library(ggplot2)
library(shinyBS)
library(plotly)
source("population-size-data.R")

server <- function(input, output) {
  # Redudant Code Here
  
  
  
  
  #############
  #### Home ###
  #############
  
  
  
  
  ##############
  ### Part 1 ###
  ##############
  
  # Find maximum values for each plot in order to create dynamic analysis
  population.year <- reactive({
    return(input$year.choice)
  })
  
  metric.choice <- reactive({
    return(input$metric.choice)
  })
  
  pop.crime.choice <- reactive({
    return(input$crime.choice)
  })
  
  population.crime <- reactive({
    return(filter(population.size, Year == population.year()))
  })
  
  output$plot <- renderPlot({
    if (metric.choice() == "Number of Crimes") {
      crime.choice <- gsub(" ", ".", pop.crime.choice(), fixed = TRUE)  
      y.axis.label <- "Number of Crimes (in all cities)"
    } else {
      crime.choice <- gsub(" ", ".", pop.crime.choice(), fixed = TRUE) %>% 
        paste0(".rate")
      y.axis.label <- "Rate of Crimes Per 100,000 People"
    }

    # A ggplot that represents the plotted map.
    population.size.plot <- ggplot(population.crime(),
                                   aes_string(x = "Population.group",
                                              y = crime.choice,
                                              fill = crime.choice)) +
      ggtitle(paste0("Plot of Rate Per 100,000 People / Number of ",
                          pop.crime.choice(), " in All Cities")) +
      geom_bar(stat = "identity") +
      scale_fill_gradient(low="#FF8888",high="#FF0000") +
      scale_y_continuous(y.axis.label) +
      
      scale_x_discrete("City Population Size",
                       labels = c("1,000,000 and over (Group I subset)"
                                  = "1,000,000 and over",
                                  "500,000 to 999,999 (Group I subset)"
                                  = "500,000 to 999,999",
                                  "250,000 to 499,999 (Group 1 subset)"
                                  = "250,000 to 499,999",
                                  "GROUP II (100,000 to 249,999)"
                                  = "100,000 to 249,999",
                                  "GROUP III (50,000 to 99,999)"
                                  = "50,000 to 99,999",
                                  "GROUP IV (25,000 to 49,999)"
                                  = "25,000 to 49,999",
                                  "GROUP V (10,000 to 24,999)"
                                  = "10,000 to 24,999",
                                  "GROUP VI (under 10,000)"
                                  = "under 10,000")) +
      theme(axis.text.x=element_text(angle=35, hjust=1))
    

    return(population.size.plot)

  })
  
  output$table <- renderTable({
    ##magic happens here##
    output$table <- renderTable({
      carb <- unique(population.crime()$Population.group)
      carb <- carb[order(carb)]
      x <- carb[round(input$plot_click$x)]
      population.crime[factor(population.crime()$Population.group) == x,]
    })
    
  })

  
  
  
  
  
  ##############
  ### Part 2 ###
  ##############
  
  
  
  
  
  ##############
  ### Part 3 ###
  ##############
  
  
  
  
  
  
  ##############
  ### Part 4 ###
  ##############
  
  
  
  
  
  

}
shinyServer(server)