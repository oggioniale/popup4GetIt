library("shiny")
library("plotly")
library("shinydashboard")
source("plot_JSON_from_GET-IT.R")

ui <- fluidPage(
    
    # Application title
    titlePanel("Basic dashboard"),
    # Show a plot of the generated distribution
    mainPanel(
        plotlyOutput("plot1")
    )
    # Sidebar with a slider input for number of bins 
    # sidebarLayout(
    #     # sidebarPanel(
    #     #     sliderInput("bins",
    #     #                 "Number of bins:",
    #     #                 min = 1,
    #     #                 max = 50,
    #     #                 value = 30)
    #     # ),
    # )
)

server <- function(input, output) {
    output$plot1 <- renderPlotly({
        obs <- ReLTER::get_sos_obs(
            sosURL = params$sosUrl,
            procedure = params$procedure,
            show_map = FALSE
        )
        plot_ly(obs, type = 'scatter', mode = 'lines')%>%
                add_trace(x = ~phenomenonTime, y = ~Air_Temperature, name = 'Air_Temperature')%>%
                # add_trace(x = ~Dates, y = ~AAPL, name = 'AAPL')%>%
                # add_trace(x = ~Dates, y = ~AMZN, name = 'AMZN')%>%
                # add_trace(x = ~Dates, y = ~FB, name = 'FB')%>%
                # add_trace(x = ~Dates, y = ~NFLX, name = 'NFLX')%>%
                # add_trace(x = ~Dates, y = ~MSFT, name = 'MSFT')%>%
                layout(title = 'custom tick labels with ticklabelmode="period"', legend=list(title=list(text='variable')),
                       xaxis = list(dtick = "M1", tickformat="%b\n%Y",
                                    ticklabelmode="period"), width = 1000)
    })
}

# Run the application 
shinyApp(ui = ui, server = server)