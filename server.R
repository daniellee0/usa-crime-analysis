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
output$plot <- renderPlot({
  
  if(input$states == ""){
    filtered <- gather.final %>% 
      filter(State == input$states)
    
  } else {
    
   filtered <- gather.final %>% 
     filter(input$states == State)
    
  }
 
  ggplot(data = filtered) + 
    geom_point(mapping = aes(x= Year, y= as.numeric(Total.Murders))) +
    ggtitle("Total Number of Murders per Year") +
    theme(plot.title = element_text(hjust = 0.5)) +
    labs(x= "Years", y= "Number of Murders")

    
  
})
  

  
  
  ##############
  ### Part 3 ###
  ##############
  
  
  
  
  
  
  ##############
  ### Part 4 ###
  ##############
  
  
  
  
  
  

}
shinyServer(server)