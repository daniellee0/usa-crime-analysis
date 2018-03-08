library(dplyr)
library(ggplot2)
library(shinyBS)
library(plotly)
library(shiny)
library(maps)
source("data/population-size-data.R")

server <- function(input, output) {
  # Redudant Code Here
  
  
  
  
  #############
  #### Home ###
  #############
  
  
  
  
  ##############
  ### Part 1 ###
  ##############
  
  # Find maximum values for each plot in order to create dynamic analysis
  population.year <- reactive({
    return(input$year.choice)
  })
  
  metric.choice <- reactive({
    return(input$metric.choice)
  })
  
  pop.crime.choice <- reactive({
    return(input$crime.choice)
  })
  
  population.crime <- reactive({
    return(filter(population.size, Year == population.year()))
  })
  
  output$plot <- renderPlot({
    if (metric.choice() == "Number of Crimes") {
      crime.choice <- gsub(" ", ".", pop.crime.choice(), fixed = TRUE)  
      y.axis.label <- "Number of Crimes (in all cities)"
    } else {
      crime.choice <- gsub(" ", ".", pop.crime.choice(), fixed = TRUE) %>% 
        paste0(".rate")
      y.axis.label <- "Rate of Crimes Per 100,000 People"
    }

    # A ggplot that represents the plotted map.
    population.size.plot <- ggplot(population.crime(),
                                   aes_string(x = "Population.group",
                                              y = crime.choice,
                                              fill = crime.choice)) +
      ggtitle(paste0("Plot of Rate Per 100,000 People / Number of ",
                          pop.crime.choice(), " in All Cities")) +
      geom_bar(stat = "identity") +
      scale_fill_gradient(low="#FF8888",high="#FF0000") +
      scale_y_continuous(y.axis.label) +
      
      scale_x_discrete("City Population Size",
                       labels = c("1,000,000 and over (Group I subset)"
                                  = "1,000,000 and over",
                                  "500,000 to 999,999 (Group I subset)"
                                  = "500,000 to 999,999",
                                  "250,000 to 499,999 (Group 1 subset)"
                                  = "250,000 to 499,999",
                                  "GROUP II (100,000 to 249,999)"
                                  = "100,000 to 249,999",
                                  "GROUP III (50,000 to 99,999)"
                                  = "50,000 to 99,999",
                                  "GROUP IV (25,000 to 49,999)"
                                  = "25,000 to 49,999",
                                  "GROUP V (10,000 to 24,999)"
                                  = "10,000 to 24,999",
                                  "GROUP VI (under 10,000)"
                                  = "under 10,000")) +
      theme(axis.text.x=element_text(angle=35, hjust=1))
    

    return(population.size.plot)

  })
  
  output$table <- renderTable({
    ##magic happens here##
    output$table <- renderTable({
      carb <- unique(population.crime()$Population.group)
      carb <- carb[order(carb)]
      x <- carb[round(input$plot_click$x)]
      population.crime[factor(population.crime()$Population.group) == x,]
    })
    
  })

  
  
  
  
  
  ##############
  ### Part 2 ###
  ##############
  
  
  ##############
  ### Part 3 ###
  ##############
  
  # Loads helper function that gets county name from hover coordinates
  source("data/counties-helper.R")
  
  # Loads all county crime data from 2004 to 2016
  all.counties.years <- 
    read.csv("data/violent_county_crimes_all_years.csv", 
             stringsAsFactors = FALSE)
  
  # Returns the chosen crime type symbol
  chosen.crime <- reactive({
    col.name <- input$select.crime
    col.name.sym <- rlang::sym(col.name)
    
    return(col.name.sym)
  })
  
  # Returns data frame of counties from a chosen state during a chosen year
  # and their crime reporting count for the chosen crime
  data.chosen.year <- reactive({
    chosen.year.data <- all.counties.years %>%
      filter(State == input$select.state) %>%
      filter(Year == input$slide.year) %>%
      select(County, !!chosen.crime())
    colnames(chosen.year.data) <- c("subregion", "Chosen_Year_Crime")
    chosen.year.data$subregion <- tolower(chosen.year.data$subregion)
    
    return(chosen.year.data)
  })
  
  # Returns a map data frame of the chosen state with its crime rates for
  # the selected year and chosen crime
  county.map <- reactive({
    counties <- map_data("county")
    chosen.state.counties <- subset(counties, 
                                    region == tolower(input$select.state))
    
    county.map <- left_join(chosen.state.counties, data.chosen.year())
    
    return(county.map)
  })
  
  # Returns the name of the county that was hovered over
  hovered.county <- reactive({
    chosen.longitude <- input$county.plot.hover$x
    chosen.latitude <- input$county.plot.hover$y
    if ((is.null(chosen.longitude)) && (is.null(chosen.latitude))) {
      chosen.longitude <- -120
      chosen.latitude <- 47.5
    }
    hover.points <- data.frame(x = chosen.longitude, y = chosen.latitude)
    chosen.county <- latlong2county(hover.points)
    chosen.county <- unlist(strsplit(chosen.county, ","))[2]
    
    return(chosen.county)
  })
  
  # Returns the number of reportings for the chosen crime 
  # and the county that was hovered over
  chosen.crime.count <- reactive({
    crime.report.count <- data.chosen.year() %>%
      filter(subregion == hovered.county()) 
    crime.report.count <- crime.report.count[1, 2]
    
    return(crime.report.count)
  })
  
  # Returns the chosen crime 
  chosen.crime.text <- reactive({
    chosen.crime <- gsub("\\.", " ", input$select.crime)
    
    return(chosen.crime)
  })
  
  # Returns a color-coded map of the counties within a chosen state
  # based on their crime reporting count
  output$county.plot <- renderPlot({
    map <- ggplot(data = county.map()) +
      geom_polygon(aes(x = long, y = lat, group = group, 
                       fill = Chosen_Year_Crime), 
                   color = "white", size = 0.6) +
      scale_fill_gradient(low = "#fef0d9", high = "#b30000", 
                          name = "# of reports")
    
    return(map)
  })
  
  # Returns a statement about the county that was hovered over
  output$county.plot.info <- renderText({
    statement <- paste0(toupper(hovered.county()), " COUNTY", "\n", 
                        "Number of Reports: ", chosen.crime.count())
    
    return(statement)
  })
  
  # Returns the visualization's title
  output$map.title <- renderText({
    title <- paste0(input$slide.year, " ", chosen.crime.text(), 
                    " Reports in ", input$select.state)
    
    return(title)
  })
  
  # Returns the analysis statement
  output$analysis.statement <- renderText({
    county <- data.chosen.year() 
    county.most.crimes <- county[which.max(county$Chosen_Year_Crime),]
    county.most.crimes.name <- county.most.crimes[1, 1]
    county.most.crimes.count <- county.most.crimes[1, 2]
    
    county.least.crimes <- county[which.min(county$Chosen_Year_Crime),]
    county.least.crimes.name <- county.least.crimes[1, 1]
    county.least.crimes.count <- county.least.crimes[1, 2]
    
    county.diff <- county.most.crimes.count - county.least.crimes.count
    
    statement <- paste0("In ", input$select.state, " during ", 
                        input$slide.year, 
                        ", the county with the most reports for ",
                        tolower(chosen.crime.text()), " was ", 
                        county.most.crimes.name, " county with ", 
                        county.most.crimes.count, 
                        " reports. The county with the least reports for ", 
                        tolower(chosen.crime.text()), " was ", 
                        county.least.crimes.name, " county with ", 
                        county.least.crimes.count, 
                        " reports, which had ", county.diff, 
                        " less crime reports than ", 
                        county.most.crimes.name, " county.")
    
    return(statement)
  })
  
  ##############
  ### Part 4 ###
  ##############
  
  
  
  
  
  

}

shinyServer(server)