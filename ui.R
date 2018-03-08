library(shiny)
library("shinythemes")
# To load some ui elements
source("firearms.R")
ui <- fluidPage(theme = shinytheme("flatly"),
  navbarPage("United States Crime Analysis",
             fluid = TRUE,
             
             #############
             #### Home ###
             #############
             tabPanel("Home",
                      fluidRow(
                        column(8, includeMarkdown("home.md")),
                        column(4, includeMarkdown("logo.md"))
                        )
                      ),

             ##############
             ### Part 1 ###
             ##############
             # Create tab for population size
             tabPanel("Population Size", 
                      h2("Crimes By Population Size"), 
                      p(tags$strong("Introduction:"),
                        "This section analyzes the effect of a city's 
                        population size on the frequency of crime and whether 
                        or not people should be concerned about crimes  
                        relative to other population sizes. This section  
                        displays the rate of crime per 100,000 people or   
                        the number of crimes that have occured based on a   
                        given year, chosen metric, and specific crime. In   
                        particular, this section answers the question of what 
                        people should be most concerned about in regards 
                        to how population size is or isn't related to crime 
                        prevalence."),

                        # Organize by sidebars
                      sidebarLayout(
                        
                        sidebarPanel(
                          
                          # User inputs
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
                          
                          # Contains plot output with click interactions
                        mainPanel(
                          
                          plotOutput('population.plot', 
                                      click = "plot_click"),
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
                            have a population size of ", 
                            textOutput("pop.size", inline = TRUE))
                          )
                        )
                      ),
             
             ##############
             ### Part 2 ###
             ##############
             # Create tab for Firearms and Murder in the US
             tabPanel("Firearms and Murder",
                      h2("Firearm and Murders By State"),
                      
                      p(tags$strong("Introduction:"),"A question many 
                          Americans are think about due to recent events is  
                          whether or not our gun laws need to be more strict.
                          Would this prevent mass shootings, murders, and 
                          overall violence? The data below compares the total  
                          amount of murders in a state, and whether the murder 
                          was committed with a firearm or not."),
                      
                      sidebarLayout(
                        sidebarPanel(
                          
                          # Create drop down menu for choosing a states
                          selectInput("states", label = "Choose a State:",
                                      choices = join.final$State,
                                      multiple = FALSE,
                                      selected = "Washington")
                           ),
                        mainPanel(
                          
                          plotOutput("plot"), width = 8,
                          
                          br(), # Insert break
                          
                          tags$i("Alabama had no data reported for 2011. Small 
                            amounts of reported data for years 2012-2016."),
                          
                          br(),
                          
                          p("In the plots above it shows how many murders there 
                          were in a given year in a state. Some states, like 
                          Alabama had issues with reporting murders and for  
                          this reason some of the data may be skewed."),
                          
                          br(), # Insert break
                          
                          p("Some factors that could skew the data include:"),
                          
                          tags$ol(
                            tags$li ("Population Size"),
                            tags$li ("Gun Laws within the State"),
                            tags$li ("Citizens that exercise their right to 
                                 bear arms"),
                            tags$li ("Crime within the States")
                            
                            ),
                          
                          br(), # Insert break
                          
                          textOutput("analysis"),
                          
                          br() # Insert break
                          )
                        )
                      ),

             ##############
             ### Part 3 ###
             ##############

             # Organizes the tab for county crimes by state
             tabPanel("County Crimes By State",
                      
                      h2("County Crimes By State"),
                      
                      # Introduces the tab section
                      p(strong("Introduction: "), "This section compares the
                        report counts for a particular crime type between 
                        counties within a chosen state, during a certain 
                        year. It also encourages the understanding on 
                        what counties may need further crime prevention
                        and intervention, how crimes have evolved in counties
                        over the years, and insight on actions regarding 
                        personal safety.", align = "left"),
                      
                      # Bulleted list of tips for interacting with map
                      tags$ul(
                        
                        tags$li("The ", em("darker"), " in color a county is, 
                           the more crimes have been reported there."),
                        tags$li("Data was unable to be provided for counties 
                           that are", em("grey.")),
                        tags$li(em("Hover"), " over a county to discover below 
                                its ", strong("county name"), " and exact ", 
                                strong("report count"), 
                                " for the chosen crime.")
                      ),
                      
                      # Organizes two-sided layout
                      sidebarLayout(
                        
                        # Organizes side panel
                        sidebarPanel(
                          
                          # Allows user to slide and choose a year between
                          # 2005 and 2016
                          sliderInput('slide.year', 
                                      label = "Choose a year:", min = 2005, 
                                      max = 2016, value = 2010, sep = ""),
                          
                          # Allows user to select a state using drop
                          # down menu
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
                          
                          # Allows user to select a crime using drop down menu
                          selectInput('select.crime', 
                                      label = "Select a crime of interest:", 
                                      choices = c("Murder and nonnegligent 
                                                  manslaughter" = 
                                                    "Murder.and.Nonnegligent.Manslaughter", 
                                                  "Forcible rape" = 
                                                    "Forcible.Rape", 
                                                  "Robbery" = "Robbery", 
                                                  "Aggravated assault" = 
                                                    "Aggravated.Assault", 
                                                  "Burglary" = "Burglary", 
                                                  "Larceny theft" = 
                                                    "Larceny.Theft", 
                                                  "Motor vehicle theft" = 
                                                    "Motor.Vehicle.Theft", 
                                                  "Arson" = "Arson"), 
                                      selected = "Burglary")
                        ), 
                        
                        # Main map panel
                        mainPanel(
                          
                          # Creates map title
                          h3(textOutput('map.title'), align = "center"),
                          
                          # Creates the map itself
                          plotOutput('county.plot', 
                                     hover = "county.plot.hover"), 
                          
                          # Creates the text provided when hovering
                          verbatimTextOutput("county.plot.info"),
                          
                          # Writes an analysis statement
                          textOutput('analysis.statement'),
                          
                          br(),
                          
                          # Writes a disclaimer message
                          em(p(strong("Disclaimer: "), "A significant amount
                            of states are missing for the 2006 data. 
                            Additionally, the visualization above does not 
                            account for population sizes which may slightly 
                            alter the meaning of the crime report counts to
                            be more or less severe."))
                        )
                      )
             ),
             
             ##############
             ### Part 4 ###
             ##############
             tabPanel("Hate Crimes By Category",
                      # Include a title
                      titlePanel("Hate Crime Statistics"),
                      
                      # introduce the section
                      p(strong("Introduction: "), "This section compares the
                      number of incidents for hate crimes against 
                      different populations from 2005 to 2016. The question we
                      hope to answer is how do the trends we see over time
                      correspond to real world events? These trends should give 
                      individuals a better sense of the tensions that exist 
                      toward different groups. They should aslo help law 
                      enforcement initiate preventative programs to defuse 
                      these tensions.", 
                      align = "left"),
                      
                      # Include a `sidebarLayout()
                      sidebarLayout(
                        sidebarPanel(
                          
                          # A slectInput labeled "Category", with choices
                          # "Race", "Religion", "Sexual Orientaiton" and 
                          # "Disability"
                          selectInput(inputId = "category",
                                      label = "Category:",
                                      choices = c("Race", "Religion",
                                                  "Sexual Orientation", 
                                                  "Disability"),
                                      selected = "Race")
                          ),
                        
                        # The layout's `mainPanel()` should have the following
                        # reactive outputs:
                        mainPanel(
                          
                          # A line graph showing the trend of hate crime 
                          # incidents
                          plotOutput('hatecrime'),

                          p(strong("Race: "), "The graph shows a steady trend
                          for most of the ethnic groups. However, there is 
                          a dramatic drop for hate crimes against African
                          Americans starting from 2008, which is when president 
                          Obama was elected, until 2016.", 
                          align = "left"),
                          
                          # Analysis paragraph for Religion graph
                          p(strong("Religion: "), "The graph shows that 
                          anti-islamic incidents increased dramaticly after  
                          2014, which is when the Islamic State seized large 
                          swathes of territory in Syria and Iraq. On the other 
                          hand, anti-Jewish incidents had dropped since 2008.", 
                          align = "left"),
                          
                          # Analysis paragraph for Sexual Orientation graph
                          p(strong("Sexual Orientation: "), "The graph shows 
                          that the number of anti-homosexual incidents dropped 
                          steadily since 2011 when New York became the largest 
                          state to allow same-sex marriage.", align = "left"),
                          
                          # Analysis paragraph for Disability graph
                          p(strong("Disability: "), "The graph shows 
                          a huge drop for anti-mental disability incidents in 
                          2010. The year in which The Equality Act was passed
                          to protect people with disabilities and prevent  
                          disability discrimination. However, the number  
                          bounced back up from 2010 to 2012.", align = "left"),
                          
                          br(),
                          
                          # Writes a disclaimer message
                          em(p(strong("Disclaimer: "), "The categories above 
                            were provided by the FBI publications. It does not
                            include all the hate crimes against each group.
                            Additionally, the visualization above does not 
                            account for the population size for each group
                            which may slightly alter the meaning of the crime 
                            report."))
                          )
                        )
                      ),
             br(),
             hr(),
             p("INFO 201 | Winter 2018: Lea Quan, Tammy Ho, Ciarra Hart, 
               Daniel Lee", align = "center")
             )
  )
shinyUI(ui)