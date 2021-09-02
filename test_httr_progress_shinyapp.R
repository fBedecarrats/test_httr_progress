# library(remotes)
# install_github(repo =  "https://github.com/JohnCoene/waiter")
library(shiny)
library(waiter)
library(httr)

# A UI where we want to see a progress bar on the navbar
ui <- navbarPage("A navbar to visualize progress",
                 tabPanel("Trigger download",
                          useWaitress(),
                          actionButton("dwld", "Download !")
    )
)
                 

    

# Define server logic required to draw a histogram
server <- function(input, output) {
    observeEvent(input$dwld, {
        waitress <- Waitress$new("nav", theme = "overlay", min = 0, max = 10)
        
        for(i in 1:10){
            waitress$inc(1) # increase by 10%
            Sys.sleep(.5)
        }
        waitress$close()

    })

}

# Run the application 
shinyApp(ui = ui, server = server)
