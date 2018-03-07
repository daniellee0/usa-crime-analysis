# Redundant Code here
library("dplyr")
library("shiny")
library("ggplot2")
library("maps")

server <- function(input, output) {
  # Redudant Code Here
  
  
  
  
  #############
  #### Home ###
  #############
  
  
  
  
  ##############
  ### Part 1 ###
  ##############
  
  
  
  
  
  ##############
  ### Part 2 ###
  ##############
  
  # Loads helper function that gets county name from hover coordinates
  source("counties-helper.R")
  
  # Loads all county crime data from 2004 to 2016
  all.counties.years <- 
    read.csv("data/violent_county_crimes_all_years.csv", 
             stringsAsFactors = FALSE)
  
  # Returns the chosen crime type
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
  
  output$map.title <- renderText({
    chosen.crime <- gsub("\\.", " ", input$select.crime)
    title <- paste0(input$slide.year, " ", chosen.crime, 
                    " Reports in ", input$select.state)
    
    return(title)
  })
  
  ##############
  ### Part 3 ###
  ##############
  
  
  
  
  
  
  ##############
  ### Part 4 ###
  ##############
  
  
  
  
  
  

}

shinyServer(server)