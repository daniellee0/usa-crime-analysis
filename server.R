# Redundant Code here
library("dplyr")
library("shinythemes")
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
  
# Create plot for total murders per year
output$plot <- renderPlot({
  
  if(input$states == ""){
    filtered <- join.firearms.murders %>% 
      filter(State == input$states) %>% 
      select(State,Year, Total.Firearms, Total.Murders)
    
  } else {
    
   filtered <- join.firearms.murders %>% 
     filter(input$states == State) %>% 
     select(State, Year, Total.Murders, Total.Firearms)
    
  }
 # Create ggplot of murders per year based on state
   ggplot(data = filtered) + 
    geom_point(mapping = aes(x = Year, y= as.numeric(Total.Murders)), color = "red") +
    geom_smooth(aes(x= Year, y= Total.Murders)) +
    geom_point(mapping = aes(x = Year, y= as.numeric(Total.Firearms)), color = "blue") +
    geom_smooth(aes(x= Year, y= Total.Firearms)) +
    ggtitle("Total Number of Murders per Year") +
    labs(x= "Years", y= "Number of Murders")
  
    })
output$analysis <- renderText({
  crime <- join.firearms.murders %>% 
    filter(input$states == State, "2016" == Year)
  
  
    
    

})

  
  
  ##############
  ### Part 3 ###
  ##############
  
  
  
  
  
  
  ##############
  ### Part 4 ###
  ##############
  
  
  
  
  
  

}
shinyServer(server)