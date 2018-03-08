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
             tabPanel("Hate Crimes By Category",
                # Include a title
                titlePanel("Hate Crime Statistics"),
                
                p(strong("Introduction: "), "This section compares the
                  number of incidents for hate crimes against 
                  different categories from 2005 to 2016. The question we
                  hope to answer is how do the trends we see over time
                  correspond to real world events? These trends should give 
                  individuals a better sense of the tensions that exist 
                  toward different groups. They should aslo help law enforcement initiate 
                  preventative programs to defuse these tensions.", 
                  align = "left"),
                
                # Include a `sidebarLayout()`
                sidebarLayout(
                  
                  sidebarPanel(
                    
                    # A slectInput labeled "Bias Motivation", with choices 
                    # "Race", "Religion", "Sexual Orientaiton" and "Disability"
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
                    
                    # A line graph showing the trend of hate crime incidents
                    plotOutput('hatecrime'),
                    p(strong("Race: "), "The graph shows a steady trend
                      for most of the ethnic groups. However, there is 
                      a dramatic drop for hate crimes against African
                      Americans starting from 2008, which is when president 
                      Obama was elected, until 2016.", 
                      align = "left"),
                    p(strong("Religion: "), "The graph shows that anti-islamic
                      incidents increased dramaticly after 2014, which is when 
                      the Islamic State seized large swathes of territory in
                      Syria and Iraq. On the other hand, anti-Jewish incidents
                      had dropped since 2008.", 
                      align = "left"),
                    p(strong("Sexual Orientation: "), "The graph shows 
                      that the number of anti-homosexual incidents dropped steadily
                      since 2011 when New York became the largest state to allow
                      same-sex marriage.", align = "left"),
                    p(strong("Disability: "), "The graph shows 
                      a huge drop for anti-mental disability incidents in 2010.
                      The year in which The Equality Act was passed
                       to protect people with disabilities and prevent disability 
                      discrimination. However, the number bounced back up from
                      2010 to 2012.", align = "left"),
                    br(),
                    # Writes a disclaimer message
                    em(p(strong("Disclaimer: "), "The categories above were
                            provided by the FBI publications. It does not
                            include all the hate crimes against each group.
                            Additionally, the visualization above does not 
                            account for the population size for each group
                            which may slightly alter the meaning of the crime 
                            report."))
                  )
                )
             )     
                      
                      
                      
             ),
             br(),
             hr(),
             p("INFO 201 | Winter 2018 | Lea Quan, Tammy Ho, Ciarra Hart, Daniel Lee", align = "center")
  )
  
  
  
shinyUI(ui)