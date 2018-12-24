

library(shiny)
shinyServer(function(input, output) {
  airquality$Tempsp <-ifelse(airquality$Temp - 65 > 0,airquality$Temp - 65,0)
  model1 <-lm(Solar.R~Temp,data=airquality)
  model2 <-lm(Solar.R~Tempsp+Temp,data=airquality)
  
  model1pred <-reactive({
    TempInput <-input$sliderTEMP
    predict(model1,newdata=data.frame(Temp=TempInput))
  })
  model2pred <-reactive({
    TempInput <-input$sliderTEMP
    predict(model2,newdata=data.frame(Temp=TempInput,Tempsp=ifelse(TempInput-65>0,TempInput-65,0)))
  })
   
  output$plot1 <- renderPlot({
    TempInput <-input$sliderTEMP
    plot(airquality$Temp,airquality$Solar.R,xlab="Temp",ylab="Solar.R",bty="n",pch=16,xlim=c(50,100),
         ylim=c(5,350))
    if(input$showModel1){
      abline(model1,col="red",lwd=2)
    }
    if(input$showModel2){
      model2lines <-predict(model2,newdata=data.frame(Temp=50:100,Tempsp=ifelse(50:100 - 65>0,
                                                                                50:100-65,0)))
    
      lines(50:100,model2lines,col="blue",lwd=2)
    }
    legend(85,50,c("Model 1 Prediction","Model 2 Prediction"),pch=16,col=c("red","blue"),bty="n",cex=1.2)
    
    points(TempInput,model1pred(),col="red",pch=16,cex=2)
    points(TempInput,model2pred(),col="blue",pch=16,cex=2)
  })
  output$pred1 <-renderText({
    model1pred()
  })
  output$pred2 <-renderText({
    model2pred()
  })
  })

