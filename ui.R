
library(shiny)
library(shinydashboard)

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Parental Verification"),
  sidebarPanel(
    textInput("os_barcode","Offspring Barcode"),
    actionButton("verify","Check Parents"),
    textOutput("verified")
  ),
  mainPanel(
   tableOutput("marker_table")
  )
)

