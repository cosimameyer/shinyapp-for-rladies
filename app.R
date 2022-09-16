library(shiny) # Shiny
library(ggplot2) # For plotting
library(dplyr) # For data wrangling
library(overviewR) # To get the data

data(toydata)

#---------------------------------------------------------#
##UI 👤
ui <- fluidPage(titlePanel ("Visualization"),
                ###Define sidebar
                sidebarLayout(sidebarPanel(
                  checkboxGroupInput(
                    "countries",
                    h4("Select the countries"),
                    choices = unique(toydata$ccode),
                    selected = c("RWA", "AGO")
                  )
                ),
                ###Show the visualization
                mainPanel(plotOutput("first_plot"))))

#---------------------------------------------------------# 
##Server 🧠
server <- function (input, output) {
  output$first_plot <-
    renderPlot({
      ###Generate a normal ggplot2 with some data wrangling
      toydata %>%
        dplyr::filter(ccode %in% input$countries) %>%
        dplyr::mutate(year = as.integer(year)) %>% 
        ggplot2::ggplot(aes(x = year, y = population)) +
        ggplot2::geom_col() +
        ggplot2::facet_wrap( ~ ccode) + 
        ggplot2::theme_minimal()
    })
}

#---------------------------------------------------------#
##Let it run 🏃️
shinyApp (ui = ui, server = server)

