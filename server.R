# Redundant Code here
library("dplyr")
source("firearms.R")


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
  output$map <- renderPlot({  
    # Colors for cut
    colors <- c("#a6cee3", "#1f78b4", "#b2df8a",
                "#33a02c",
                "#fb9a99",
                "#e31a1c",
                "#fdbf6f",
                "#ff7f00",
                "#cab2d6",
                "#6a3d9a",
                "#ffff99", "#b15928")    
    
    # If button is Total Murder  
    if(input$total.choice == "Total Murders"){
      scale <- united.join.murders %>% 
        filter(input$Year == Year) %>%
        select(Range, long, lat, group, State)
      
      
      
      
      # Else Total Firearms    
    } else {
      scale <- united.join.firearms %>% 
        filter(input$Year == Year) %>% 
        select(Range, long, lat, group)
      
      
    }
    
    # Plot map data reactive
    ggplot(data = scale) + 
      geom_polygon(aes(x = long, y = lat , group = group, fill = Range)) +
      coord_quickmap() +
      scale_fill_manual(values = colors) +
      ggtitle("Firearms and Murder") +
      labs(x= "Longitude", y= "Latitude")
    
  }) 
  

  
  
  ##############
  ### Part 3 ###
  ##############
  
  
  
  
  
  
  ##############
  ### Part 4 ###
  ##############
  
  
  
  
  
  

}
shinyServer(server)