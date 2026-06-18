library(shiny)
library(ggplot2)
library(dplyr)

data <- read.csv("./mortality.csv")

ui <- fluidPage(

  titlePanel("Mortality Dashboard"),

  tableOutput("summary"),

  plotOutput("plot")
)

server <- function(input, output){

  output$summary <- renderTable({

    data %>%
      mutate(
        mortality_rate =
        deaths/population*1000
      )
  })

  output$plot <- renderPlot({

    ggplot(
      data,
      aes(
        county,
        deaths
      )
    ) +
    geom_col()
  })
}

shinyApp(ui, server)