# Source in all data tables from 2004 to 2016 for firearms
source("firearms.R")


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
             tabPanel("Firearms and Murder in the United States",
                 sidebarLayout(

                   sidebarPanel(
                    
                     # Create drop down menu for choosing a state
                     
                     # Create radio button for total murders and total firearms
                     radioButtons("total.choice", label = "Choose a Total", choices = list("Total Murders by Firearms" = "Total.Firearms", "Total Murders in State" = "Total")),
                     
                     selectInput("states", label = "Choose a State:", choices = join.final$State, multiple = FALSE, selected = "washington")
                     
                   ),
                   mainPanel(
                     p("A question many Americans are think about due to recent events is whether or not our gun laws need to be more strict.
                       Would this prevent mass shootings, murders, and overall violence? The data below compares the total amount of murders in
                       a state, and whether the murder was committed with a firearm or not."),
                     br(),
                     plotOutput("plot"), width = 8,
                     
                     br(),
                     
                     p("In the plots above it shows how many murders there were in a given year in a state. Some states, like Alabama had issues with reporting
                        murders and for this reason some of the data may be skewed."),
                     br(),
                     p("Some factors that could skew the data include:"),
                     tags$ol(
                        tags$li ("Population Size"),
                        tags$li ("Gun Laws within the State"),
                        tags$li ("Citizens that exercise their right to bear arms"),
                        tags$li ("Crime within the States")
                        ),
                     br()
                     
                   )
                   
                 )
                 
                


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
