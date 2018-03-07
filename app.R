library("shiny") 

source("ui.R")
source("server.R")

# create and run the shiny app
shinyApp(ui = ui, server = server)