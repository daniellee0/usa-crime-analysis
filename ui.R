library(dplyr)
library(markdown)
library(shiny)
library(shinythemes)

# x - years
# rows - state
ui <- fluidPage(theme = shinytheme("united"),
  navbarPage("United States Crime Data",
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
             tabPanel("Population Size",
                      fluidRow(
                        h3("\"Should You be Concerned about Crime Rates Based on Population Size?\""),
                        p("This plot displays the rate of crime or the number of
                          crimes that have occured based on a given year, chosen
                          metric, and specific crime. In particular, this section
                          answers the question of what people should be most
                          concerned about in regards to how population size is
                          or isn't related to crime prevalence.")
                        ),

                      fluidRow(
                        sidebarLayout(
                          sidebarPanel(
                            sliderInput("year.choice", "Select a Year",
                                        min = 2005, max = 2016, step = 1, value = 2005,
                                        sep = ""),
                            selectInput("metric.choice", "Select a Metric",
                                        choices = c("Number of Crimes",
                                                    "Rate of Crimes Per 100,000"),
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
                            tableOutput("table")
                          )
                        )
                      )
                    ),

             ##############
             ### Part 2 ###
             ##############
             tabPanel("Firearms and Murder in the United States",
                 sidebarLayout(

                   sidebarPanel(

                     # Create drop down menu for choosing a states
                     selectInput("states", label = "Choose a State:", choices = join.final$State, multiple = FALSE, selected = "Washington")

                   ),
                   mainPanel(
                     br(), # Insert break

                     p(tags$strong("Introduction:"),"A question many Americans are think about due to recent events is whether or not our gun laws need to be more strict.
                       Would this prevent mass shootings, murders, and overall violence? The data below compares the total amount of murders in
                       a state, and whether the murder was committed with a firearm or not."),

                     br(), # Insert break

                     plotOutput("plot"), width = 8,

                     br(), # Insert break

                     tags$i("Alabama had no data reported for 2011. Small amounts of reported data for years 2012-2016."),

                     br(),

                     p("In the plots above it shows how many murders there were in a given year in a state. Some states, like Alabama had issues with reporting
                        murders and for this reason some of the data may be skewed."),

                     br(), # Insert break

                     p("Some factors that could skew the data include:"),
                     tags$ol(
                        tags$li ("Population Size"),
                        tags$li ("Gun Laws within the State"),
                        tags$li ("Citizens that exercise their right to bear arms"),
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
                          em(p(strong("Disclaimer: "), "A significant amount of states
                            are missing for the 2006 data. Additionally,
                            the visualization above does not account for
                            population sizes which may slightly alter
                            the meaning of the crime report counts to
                            be more or less severe."))
                        )
                      )
             ),

             ##############
             ### Part 4 ###
             ##############
             tabPanel("Tab 4",
                tags$p("Tab 4")




             ),

             tabPanel("References",
                      includeMarkdown("libraries.md")
             ),
             br(),
             hr(),
             p("INFO 201 | Winter 2018: Lea Quan, Tammy Ho, Ciarra Hart, Daniel Lee", align = "center")
  )
)

shinyUI(ui)
