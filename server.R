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
  source("counties-helper.R")
  
  all.counties.years <- 
    read.csv("data/violent_county_crimes_all_years.csv", 
             stringsAsFactors = FALSE)
  
  chosen.crime <- reactive({
    col.name <- input$select.crime
    col.name.sym <- rlang::sym(col.name)
    
    return(col.name.sym)
  })
  
  data.chosen.year <- reactive({
    chosen.year.data <- all.counties.years %>%
      filter(State == input$select.state) %>%
      filter(Year == input$slide.year) %>%
      select(County, !!chosen.crime())
    colnames(chosen.year.data) <- c("subregion", "Chosen_Year_Crime")
    chosen.year.data$subregion <- tolower(chosen.year.data$subregion)
    
    return(chosen.year.data)
  })
  
  #data.2016 <- reactive({
  #  data.2016 <- all.counties.years %>%
  #    filter(State == input$slide.state) %>%
  #    filter(Year == 2016) %>%
  #    select(County, !!chosen.crime())
  #  colnames(data.2016) <- c("subregion", "Chosen_Crime_2016")
  #  data.2016$subregion <- tolower(data.2016$subregion)
    
  #  return(data.2016)
  #})
  
  county.map <- reactive({
    counties <- map_data("county")
    chosen.state.counties <- subset(counties, 
                                    region == tolower(input$select.state))
    
    county.map <- left_join(chosen.state.counties, data.chosen.year())
    
    return(county.map)
  })
  
  output$county.plot <- renderPlot({
    map <- ggplot(data = county.map()) +
      geom_polygon(aes(x = long, y = lat, group = group, 
                       fill = Chosen_Year_Crime), 
                   color = "white", size = 0.6) +
      scale_fill_gradient(low = "#fef0d9", high = "#b30000", 
                          name = "# of crime reports")
    
    return(map)
  })
  
  output$county.plot.info <- renderText({
    chosen.longitude <- input$county.plot.hover$x
    chosen.latitude <- input$county.plot.hover$y
    if ((is.null(chosen.longitude)) && (is.null(chosen.latitude))) {
      chosen.longitude <- -120
      chosen.latitude <- 47.5
    }
    hover.points <- data.frame(x = chosen.longitude, y = chosen.latitude)
    chosen.county <- latlong2county(hover.points)
    chosen.county <- unlist(strsplit(chosen.county, ","))[2]
    
    crime.report.count <- data.chosen.year() %>%
      filter(subregion == chosen.county) 
    crime.report.count <- crime.report.count[1, 2]
    
    statement <- paste0("County: ", toupper(chosen.county), "\n", 
                        "Number of Reports: ", crime.report.count)
      
    return(statement)
  })
  
  ##############
  ### Part 3 ###
  ##############
  
  
  
  
  
  
  ##############
  ### Part 4 ###
  ##############
  
  
  
  
  
  

}

shinyServer(server)