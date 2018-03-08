library("dplyr")
library("ggplot2")
library("shinyBS")
library("plotly")
library("markdown")
library("maps")
source("data/population-size-data.R")

server <- function(input, output) {
  
  ##############
  ### Part 1 ### Population Size Crime
  ##############
  
  # Reactive variables to store input
  population.year <- reactive({
    return(input$year.choice)
  })
  
  metric.choice <- reactive({
    return(input$metric.choice)
  })
  
  pop.crime.choice <- reactive({
    return(input$crime.choice)
  })
  
  # Reactive variable representing filtering population crime data table based 
  # on input year
  population.crime <- reactive({
    population.crime <- filter(population.size, Year == population.year())
    return(population.crime)
  })
  
  # Reactive variable representing factors of different population groups, used
  # for plot
  population.levels <- reactive({
    population.levels <- factor(population.crime()$Population.group, 
                                levels = c("1,000,000 and over (Group I subset)",
                                           "500,000 to 999,999 (Group I subset)",
                                           "250,000 to 499,999 (Group I subset)",
                                           "GROUP II (100,000 to 249,999)",
                                           "GROUP III (50,000 to 99,999)",
                                           "GROUP IV (25,000 to 49,999)",
                                           "GROUP V (10,000 to 24,999)",
                                           "GROUP VI (under 10,000)"))
    
    return(population.levels)
  })
  
  # Reactive variable representing crime choice input in the form of a column  
  # in the datatable
  col.crime.choice <- reactive({
    if (metric.choice() == "Number of Crimes") {
      return(gsub(" ", ".", pop.crime.choice(), fixed = TRUE)) 
    } else {
      crime.choice <- gsub(" ", ".", pop.crime.choice(), fixed = TRUE) %>% 
        paste0(".rate") 
      return(crime.choice)
    }
  })
  
  # Output variables returning inputs
  output$population.year <- renderText({
    return(population.year())
  })
  
  output$metric.choice <- renderText({
    return(tolower(metric.choice()))
  })
  
  output$pop.crime.choice <- renderText({
    return(tolower(pop.crime.choice()))
  })
  
  # Reactive variable returning significant values
  significant.value <- reactive({
    significant.value <- select(population.crime(), col.crime.choice()) %>% 
      max()
    return(significant.value)
  })
  
  # Output that returns text for the significant value
  output$sig.value <- renderText({
    return(significant.value())
  })
  
  # Output that returns the population size for the significant value
  output$pop.size <- renderText({
    col <- as.symbol(col.crime.choice())
    pop.size <- filter(population.crime(), (!!col) == significant.value()) %>% 
      select(Population.group)
    return(paste0(pop.size))
  })
  
  # Output using ggplot that represents 
  output$population.plot <- renderPlot({
    if (metric.choice() == "Number of Crimes") {
      y.axis.label <- "Number of Crimes (in all cities)"
    } else {
      y.axis.label <- "Rate of Crimes Per 100,000 People"
    }
    
    # A ggplot that represents the plotted map for number of crime / crime
    # rate based on two inputs: crime choice and year choice
    population.size.plot <- ggplot(population.crime(),
                                   aes_string(x = population.levels(),
                                              y = col.crime.choice(),
                                              fill = col.crime.choice())) +
      ggtitle(paste0("Plot of Rate Per 100,000 People / Number of ",
                          pop.crime.choice(), " in All Cities")) +
      geom_bar(stat = "identity") +
      scale_fill_gradient(name = y.axis.label, low="#FF8888",high="#FF0000") +
      scale_y_continuous(y.axis.label) +
      scale_x_discrete("City Population Size",
                       labels = c("1,000,000 and over (Group I subset)"
                                  = "1,000,000 and over",
                                  "500,000 to 999,999 (Group I subset)"
                                  = "500,000 to 999,999",
                                  "250,000 to 499,999 (Group I subset)"
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
      theme(axis.text.x=element_text(angle=25, hjust=1))
    return(population.size.plot)
    
  })
  
  # Returns the x value (bar plot value)
  output$x_value <- renderText({
    if (is.null(input$plot_click$x)) {
      return("Please select a bar value")
    }
    
    x.value <- population.levels()[round(input$plot_click$x)]
    y.value <- filter(population.crime(), Population.group == x.value) %>% 
      select(col.crime.choice())
    paste0("Selection: ", x.value, "\n", metric.choice(), ": ", y.value)
    })


  ##############
  ### Part 2 ### Firearm / Murder Crime
  ##############
  # Create plot for total murders per year
  output$plot <- renderPlot({
    if(input$states == ""){
      filtered <- join.firearms.murders %>%
        filter(State == input$states) %>%
        select(State,Year, Total.Firearms, Total.Murders)
      } else {
        filtered <- join.firearms.murders %>%
          filter(input$states == State) %>% 
          select(State, Year, Total.Murders, Total.Firearms)
        
      }
    
    # Create ggplot of murders per year based on state
    ggplot(data = filtered) + 
      geom_point(aes(x = as.numeric(Year), y= Total.Murders,
                              color = "Total Murders")) +
      geom_point(aes(x = as.numeric(Year), y= Total.Firearms,
                            color = "Murders with Firearms")) +
      scale_color_manual(name = "Murder Category", 
                        labels = c("Murders with Firearms", "Total Murders"),
                        values = c("red", "blue")) +
     geom_smooth(data = filtered, aes(x= as.numeric(Year), 
                                      y= as.numeric(Total.Murders)), color = "blue") +
     geom_smooth(data = filtered, aes(x= as.numeric(Year), 
                                      y= as.numeric(Total.Firearms)), color = "red") +
      ggtitle("Total Number of Murders per Year") +
      labs(x= "Years", y= "Number of Murders")
    })
  
  # Output analysis for the question
  output$analysis <- renderText({
    crime <- join.firearms.murders %>% 
     filter(input$states == State, "2016" == Year) %>% 
     select(Total.Firearms, Total.Murders) %>% 
     summarise(value = Total.Firearms / Total.Murders) 

   sentence <- paste0("The percentage of murders by firearms is ", 
    signif(crime, digits = 2)*100, "% in 2016 in ", input$states, ".
                      This shows how often firearms are appart of murders 
    and could be used as evidence towards stricter gun laws.")
     return(sentence)
  })
  

  ##############
  ### Part 3 ### County Crime
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
  ### Part 4 ### Hate Crime
  ##############
  # read in the hate crime data from 2005-2016
  source("data/hate-crime-data.R")
  
  # filter the data by category, flip rows and columns and melt the data frame
  # in order to plot line graph
  filtered <- reactive({
    table <- hatecrime[hatecrime$Category == input$category, 
                       c("Bias.motivation", 2005:2016)]
    hatecrime.data <- data.frame(t(table[-1]))
    colnames(hatecrime.data) <- table[, 1]
    hatecrime.data$year <- rownames(hatecrime.data)
    melted <- melt(hatecrime.data, id.vars = "year")
    return(melted)
  })
  
    # create the line graph 
    output$hatecrime <- renderPlot({
      ggplot(data = filtered(), aes(x = year, y = value, group = variable)) +
        geom_line() +
        geom_point() +
        geom_line(aes(color = variable)) +
        geom_point(aes(color = variable)) +
      scale_color_brewer(palette = "Set1")
      })

}
shinyServer(server)