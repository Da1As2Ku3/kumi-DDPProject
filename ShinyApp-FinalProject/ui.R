

library(shiny)
shinyUI(fluidPage(
  titlePanel("Predict Solar Radiation from Temperature"),
  
  sidebarLayout(
    sidebarPanel(
      h4("This is a scatterplot of Temp and Solar.R"),
      h4("The plot reveals a positive relationship between Temp and Solar.R"),
      h4("Use Checkboxes and Submit Button to determine Predictions"),
       sliderInput("sliderTEMP","What is the surface TEMP?",50,100,value=65),
       checkboxInput("showModel1","Show/Hide Model 1",value=TRUE),
       checkboxInput("showModel2","Show/Hide Model 2",value=TRUE),
      submitButton("Submit")
    ),
    
    mainPanel(
       plotOutput("plot1"),
       h3("Predicted Solar Radiation from Model1:"),
       textOutput("pred1"),
       h3("Predicted Solar Radiation from Model2:"),
       textOutput("pred2")
    )
  )
))
