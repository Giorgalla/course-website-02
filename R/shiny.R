library(shiny)
library(ggplot2)
library(dplyr)
library(plotly)

# Generate skewed synthetic dataset
set.seed(123)

data <- tibble(
  age = sample(18:65, 100, replace = TRUE, prob = rep(c(0.05, 0.1, 0.15, 0.2, 0.25, 0.25), length.out = 48)),
  gender = sample(c("Male", "Female", "Non-binary", "Prefer not to say"), 100, replace = TRUE, prob = c(0.4, 0.4, 0.1, 0.1)),
  decision_fatigue = sample(c("Never", "Sometimes", "Often", "Always"), 100, replace = TRUE, prob = c(0.1, 0.3, 0.3, 0.3)),
  decision_confidence = sample(1:5, 100, replace = TRUE, prob = c(0.15, 0.2, 0.25, 0.25, 0.15))
)

# Shiny UI
ui <- fluidPage(
  titlePanel("Interactive Decision-Making Dashboard"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("selected_var", "Choose Variable:", choices = c("Age" = "age", "Decision Fatigue" = "decision_fatigue")),
      selectInput("plot_type", "Choose Plot Type:", choices = c("Bar Plot", "Histogram", "Scatter Plot"))
    ),
    
    mainPanel(
      plotlyOutput("interactive_plot"),
      verbatimTextOutput("summary")
    )
  )
)

# Server Logic
server <- function(input, output) {
  
  output$interactive_plot <- renderPlotly({
    req(input$selected_var)
    
    p <- ggplot(data, aes_string(x = input$selected_var)) +
      if (input$plot_type == "Bar Plot") {
        geom_bar(fill = "steelblue", color = "black")
      } else if (input$plot_type == "Histogram") {
        geom_histogram(binwidth = 5, fill = "blue", color = "black")
      } else {
        ggplot(data, aes(x = age, y = decision_confidence)) +
          geom_point(aes(color = decision_fatigue)) +
          geom_smooth(method = "lm", se = FALSE)
      }
    
    ggplotly(p)
  })
  
  output$summary <- renderPrint({
    summary(data)
  })
}

# Run the app
shinyApp(ui, server)
