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
                     
                     # Create radio button for total murders and total firearms
                     radioButtons("total.choice", label = "Choose a Total", choices = list("Total Firearms" = "Total.Firearms", "Total Murders" = "Total.Murders")),
                     
                     selectInput("states", label = "Choose a State:", choices = join.final$State, multiple = FALSE, selected = "washington")
                     
                   ),
                   mainPanel(
                     plotOutput("plot"), width = 8,
                     
                     p("In the plots above it shows how many murders there were in a given year in a state. While some years lacked reporting
                       ,for instance Alabama in the past couple years, some of the data might be slightly skewed. Many factors go into how many
                       murders are committed in a state. Some examples are, population, state gun laws about who can buy guns, crime rates that
                       may lead to murder, and many more.")
                     
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
