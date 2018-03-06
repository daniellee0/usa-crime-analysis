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
             tabPanel("Firearms in the United States",
                 sidebarLayout(

                   sidebarPanel(
                    
                     # Create drop down menu for choosing a state
                     sliderInput("Year", label = "Choose a Year", min = 2004, max = 2016, value = 2000, sep = ""),
                     
                     # Create radio button for total murders and total firearms
                     radioButtons("total.choice", label = "Choose a Total", choices = list("Total Firearms" = "Total.Firearms", "Total Murders" = "Total.Murders")),
                     
                     # Drop down
                     selectInput("states", label = "Choose a State:", choices = united.join.firearms$State, selected = NULL, multiple = FALSE)

                   ),
                   mainPanel(
                     plotOutput("map")
                     
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
