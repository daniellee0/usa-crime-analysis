ui <- fluidPage(
  navbarPage("United States Crime Data",
             #############
             #### Home ###
             #############
             tabPanel("Home",
                tags$p("Home")
                      
                      
             ),
             
             ##############
             ### Part 1 ###
             ##############
             tabPanel("Tab 1",
                tags$p("Tab 1")
                      
             ),
             
             ##############
             ### Part 2 ###
             ##############
             tabPanel("Tab 2",
                 tags$p("Tab 2")
                      
                      
             ),
             
             ##############
             ### Part 3 ###
             ##############
             tabPanel("Tab 3",
                 tags$p("Tab 3")  
                      
                      
                      
             ),
             
             ##############
             ### Part 4 ###
             ##############
             tabPanel("Tab 4",
                tags$p("Tab 4")
                      
                      
                      
                      
             ),
             p("INFO 201 | Winter 2018 | Lea Quan, Tammy Ho, Ciarra Hart, Daniel Lee", align = "center")
  )
  
  
  
  
  
  
  
)
shinyUI(ui)