## Installing from the repo
# remotes::install_github(repo =  "https://github.com/JohnCoene/waiter")
library(shiny)
library(waiter)
library(httr)

datasource <- "https://data.nantesmetropole.fr/explore/dataset/244400404_nombre-convives-jour-cantine-nantes-2011/download/?format=csv&use_labels_for_header=true"

# A UI where we want to see a progress bar on the navbar
ui <- navbarPage("A navbar to visualize progress",
                 tabPanel("Trigger download",
                          useWaitress(color = "#7F7FFF"),
                          actionButton("dwld", "Download !")
    )
)
                 


# Testing the function
server <- function(input, output) {
    
    waitress <- Waitress$new("nav", theme = "overlay", min = 0, max = 10)
    
    observeEvent(input$dwld, {
        # A 5.3Mo file
        my_data <- GET(datasource, httr_progress(waitress), 
                       write_disk("my_data.csv", overwrite = TRUE))
    })

}

# Run the application 
shinyApp(ui = ui, server = server)
