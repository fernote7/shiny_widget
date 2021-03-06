## app.R ##
library(shiny)
library(shinydashboard)

ui <- dashboardPage(
    dashboardHeader(title = "My Dashboard",
                    
                    dropdownMenuOutput("messageMenu")                
                    
    ),
    dashboardSidebar(sidebarMenu(
        menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
        menuItem("Widgets", tabName = "widgets", icon = icon("th"))
    )),
    dashboardBody(
        tabItems(
            # First tab content
            tabItem(tabName = "dashboard",
                fluidRow(
                    box(plotOutput("plot1", height = 250)),
                    
                    box(
                        title = "Controls",
                        sliderInput("slider", "Number of observations:", 1, 100, 50)
                    )
                )
            ),
            
            # Second tab content
            tabItem(tabName = "widgets",
                    h2("Widgets tab content")
            )
        )
    )
)

server <- function(input, output) {
    set.seed(122)
    histdata <- rnorm(500)
    
    output$plot1 <- renderPlot({
        data <- histdata[seq_len(input$slider)]
        hist(data)
    })
    
    output$messageMenu <- renderMenu({
        # Code to generate each of the messageItems here, in a list. This assumes
        # that messageData is a data frame with two columns, 'from' and 'message'.
        messageData <- data.frame(from = c('Fernando', 'Ana', 'Viviane', 'Luquett', 'Guilherme'),
                                  message= c('oi', 'shoow', 'woohoo!', 'pay the rent!', 'ukulele'))
        msgs <- apply(messageData, 1, function(row) {
            messageItem(from = row[["from"]], message = row[["message"]])
        })
        
        # This is equivalent to calling:
        #   dropdownMenu(type="messages", msgs[[1]], msgs[[2]], ...)
        dropdownMenu(type = "messages", .list = msgs)
    })
    
}

shinyApp(ui, server)