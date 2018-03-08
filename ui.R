library(dplyr)
library(markdown)

# x - years
# rows - state
ui <- fluidPage(
  navbarPage("United States Crime Data",
             fluid = TRUE,
             #############
             #### Home ###
             #############
             tabPanel("Home",
                fluidRow(
                  column(8, includeMarkdown("home.md")),
                  column(4, includeMarkdown("libraries.md"))
                  
                )
                      
                      
             ),
             
             ##############
             ### Part 1 ###
             ##############
             tabPanel("Population Size",
                      fluidRow(
                        h3("Crimes by Population Size"), 
                        p("This section analyzes the effect of population size
                          on the frequency of crime and whether or not people
                          should be concerned about crime in their particular
                          city. This section displays the rate of crime per 
                          100,000 people or the number of crimes that have  
                          occured based on a given year, chosen metric, and  
                          specific crime. In particular, this section answers  
                          the question of what people should be most concerned 
                          about in regards to how population size is 
                          or isn't related to crime prevalence.")
                        ),
                      
                      fluidRow(
                        sidebarLayout(
                          sidebarPanel(
                            sliderInput("year.choice", "Select a Year", 
                                        min = 2005, max = 2016, step = 1,
                                        value = 2005,
                                        sep = ""),
                            selectInput("metric.choice", "Select a Metric", 
                                        choices = c("Number of Crimes", 
                                                    "Rate of Crimes Per 
                                                    100,000"),
                                        selected = "Number of Crimes"),        
                            
                            selectInput("crime.choice", "Select a Crime", 
                                        choices = c("Violent crime",
                                                    "Murder and nonnegligent manslaughter",
                                                    "Robbery",
                                                    "Aggravated assault",
                                                    "Property crime",
                                                    "Burglary",
                                                    "Larceny theft",
                                                    "Motor vehicle theft",
                                                    "Arson"),
                                        selected = "Violent")
                          ),
                          
                          mainPanel(
                            plotOutput('plot', click = "plot_click"),
                            verbatimTextOutput("x_value"),
                            p("Based on the ", 
                              textOutput("metric.choice", inline = TRUE), 
                              " of ", 
                              textOutput("pop.crime.choice", inline = TRUE),
                              " in ", textOutput("population.year", 
                                                 inline = TRUE), 
                              " the value of concern is ", 
                              textOutput("sig.value", inline = TRUE), 
                              ". This crime value comes from cities that
                              have a population size of ", textOutput("pop.size", inline = TRUE))
                          )
                        )
                      )
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
             br(),
             hr(),
             p("INFO 201 | Winter 2018: Lea Quan, Tammy Ho, Ciarra Hart, Daniel Lee", align = "center")
  )
  
  
  
  
  
  
  
)
shinyUI(ui)