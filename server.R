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
      filtered <- gather.final %>% 
        filter(State == input$states) %>% 
        select(State,Year, Total.Firearms, Total.Murders)
      
    } else {
      
      filtered <- gather.final %>% 
        filter(input$states == State) %>% 
        select(State, Year, Total.Murders, Total.Firearms)
      
    }
    # Create ggplot of murders per year based on state
    ggplot(data = filtered, aes(x= as.numeric(Year), Y= Total.Murders)) + 
      geom_point(mapping = aes(y= as.numeric(Total.Murders)), color = "red") +
      geom_point(mapping = aes(y= as.numeric(Total.Firearms)), color = "green") +
      ggtitle("Total Number of Murders per Year") +
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