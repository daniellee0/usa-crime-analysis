#install.packages("shiny")
library("shiny")

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
             tabPanel("County Crimes By State",
                      sidebarLayout(
                        sidebarPanel(
                          sliderInput('slide.year', 
                                      label = "Choose a year:", min = 2005, 
                                      max = 2016, value = 2010, sep = ""),
                          selectInput('select.state', 
                                      label = "Select a state:", 
                                      choices = c("Alabama", "Arizona", 
                                                  "Arkansas", "California", 
                                                  "Colorado", "Delaware", 
                                                  "Florida", "Georgia", 
                                                  "Idaho", "Illinois", 
                                                  "Indiana", "Iowa", "Kansas",
                                                  "Kentucky", "Louisiana", 
                                                  "Maine", "Maryland", 
                                                  "Michigan", "Minnesota", 
                                                  "Mississippi", "Missouri", 
                                                  "Montana", "Nebraska", 
                                                  "Nevada", "New Hampshire", 
                                                  "New Jersey", "New Mexico", 
                                                  "New York", "North Carolina",
                                                  "North Dakota", "Ohio", 
                                                  "Oklahoma", "Oregon", 
                                                  "Pennsylvania", 
                                                  "South Carolina", 
                                                  "South Dakota", "Tennessee", 
                                                  "Texas", "Utah", "Vermont", 
                                                  "Virginia", "Washington", 
                                                  "West Virginia", "Wisconsin", 
                                                  "Wyoming"), 
                                      selected = "Washington"), 
                          selectInput('select.crime', 
                                      label = "Choose a crime of interest:", 
                                      choices = c("Murder and nonnegligent 
                                                  manslaughter" = 
                                                    "Murder.and.nonnegligent.manslaughter", 
                                                  "Forcible rape" = 
                                                    "Forcible.rape", 
                                                  "Robbery" = "Robbery", 
                                                  "Aggravated assault" = 
                                                    "Aggravated.assault", 
                                                  "Burglary" = "Burglary", 
                                                  "Larceny theft" = 
                                                    "Larceny.theft", 
                                                  "Motor vehicle theft" = 
                                                    "Motor.vehicle.theft", 
                                                  "Arson" = "Arson"), 
                                      selected = "Burglary")
                        ), 
                        
                        mainPanel(
                          plotOutput('county.plot', hover = "county.plot.hover"), 
                          verbatimTextOutput("county.plot.info")
                        )
                      )
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