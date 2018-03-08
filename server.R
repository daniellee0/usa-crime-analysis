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
  
<<<<<<< HEAD
# Create plot for total murders per year
output$plot <- renderPlot({
  
  if(input$states == ""){
    filtered <- join.firearms.murders %>% 
      filter(State == input$states) %>% 
      select(State,Year, Total.Firearms, Total.Murders)
=======
  # Create plot for total murders per year
  output$plot <- renderPlot({
>>>>>>> bfda9472b7f9c81a45694cd928e38927d31a58dd
    
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
    
<<<<<<< HEAD
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
    filter(input$states == State, "2016" == Year) %>% 
    select(Total.Firearms, Total.Murders) %>% 
    summarise(value = Total.Firearms / Total.Murders) 

    
  
  
  sentence <- paste0("The percentage of murders by firearms is ", signif(crime, digits = 2)*100, "% in 2016 in ", input$states, ".
                     This shows how often firearms are appart of murders and could be used as evidence towards stricter gun laws.")
    
    return(sentence)

})

=======
    
  })
  
  
>>>>>>> bfda9472b7f9c81a45694cd928e38927d31a58dd
  
  
  ##############
  ### Part 3 ###
  ##############
  
  
  
  
  
  
  ##############
  ### Part 4 ###
  ##############
  
  
  
  
  
  
  
}
shinyServer(server)