#install necessary libraries if not currently installed yet
#install.packages("shiny")
#install.packages("plotly")
#install.packages("shinyjs)

#load the necessary libraries
library(shiny)
library(plotly)
library(shinyjs)

#UI
ui <- fluidPage
(
  #Sets up the UI for interactables
  #Writes down description
  headerPanel(h1("Health tracker", align = "center")),
  br(),
  div(h5("Click the items on the right to active/deactivate the items in the table"), align = "center"),
  div(h6("Live data streamed from URL : http://ihealth.sepdek.net/"), align = "center"),
  br(),
  div(plotlyOutput("plot"), id='graph'),
  useShinyjs()
)

#Server
server <- function(input, output, session) 
{
  library(jsonlite)
  jsSepdek = fromJSON("http://ihealth.sepdek.net/")
  health <- as.data.frame(jsSepdek)
  
  values <- reactiveValues()
  
  values$p <- plot_ly(
    type = 'scatter',
    mode = 'lines'
  ) %>%
    
    #Airflow
    add_trace(
      name = health$healthData.sensor[1],
      y = c(health$healthData.value[1]),
      line = list(
        color = '#266dd3',
        width = 3
      )
    ) %>%

    #Body temperature
    add_trace(
      name = health$healthData.sensor[2],
      y = c(health$healthData.value[2]),
      line = list(
        color = '#344055',
        width = 3
      )
    ) %>%
  
    #ECG
    add_trace(
    name = health$healthData.sensor[3],
    y = c(health$healthData.value[3]),
    line = list(
      color = '#888098',
      width = 3
    )
  ) %>%
  
  #Oxygen saturation
  add_trace(
    name = health$healthData.sensor[4],
    y = c(health$healthData.value[4]),
    line = list(
      color = '#cfb3cd',
      width = 3
    )
  ) %>%
  
  #Heart rate
  add_trace(
    name = health$healthData.sensor[5],
    y = c(health$healthData.value[5]),
    line = list(
      color = '#cfb3cd',
      width = 3
    )
  ) %>%
  
  #Systolic pressure
  add_trace(
    name = health$healthData.sensor[6],
    y = c(health$healthData.value[6]),
    line = list(
      color = '#00bfb2',
      width = 3
    )
  ) %>%
  
  #Diastolic pressure
  add_trace(
    name = health$healthData.sensor[7],
    y = c(health$healthData.value[7]),
    line = list(
      color = '#1a5e63',
      width = 3
    )
  ) %>%
  
  #Pulse
  add_trace(
    name = health$healthData.sensor[8],
    y = c(health$healthData.value[8]),
    line = list(
      color = '#028090',
      width = 3
    )
  ) %>%
  
  #EMG
  add_trace(
    name = health$healthData.sensor[9],
    y = c(health$healthData.value[9]),
    line = list(
      color = '#f0f3bd',
      width = 3
    )
  ) %>%
  
  #Skin conductance
  add_trace(
    name = health$healthData.sensor[10],
    y = c(health$healthData.value[10]),
    line = list(
      color = '#c64191',
      width = 3
    )
  ) %>%
  
  #Skin resistance
  add_trace(
    name = health$healthData.sensor[11],
    y = c(health$healthData.value[11]),
    line = list(
      color = '#d0db97',
      width = 3
    )
  ) %>%
  
  #Skin conductance voltage
  add_trace(
    name = health$healthData.sensor[12],
    y = c(health$healthData.value[12]),
    line = list(
      color = '#69b578',
      width = 3
    )
  ) %>%
  
  #Glycose level
  add_trace(
    name = health$healthData.sensor[13],
    y = c(health$healthData.value[13]),
    line = list(
      color = '#3a7d44',
      width = 3
    )
  ) %>%

    layout(
      yaxis = list(title = "Sensors"),
      xaxis = list(title = "Seconds Passed")
    )
  output$plot <- renderPlotly({values$p})
  
  observe({
    invalidateLater(1000, session)
    jsSepdek = fromJSON("http://ihealth.sepdek.net/")
    health <- as.data.frame(jsSepdek)
    
    
    plotlyProxy("plot", session) %>%
      plotlyProxyInvoke("extendTraces", list(y=list(list(health$healthData.value[1]), #Airflow
                                                    list(health$healthData.value[2]), #Body temperature
                                                    list(health$healthData.value[3]), #ECG
                                                    list(health$healthData.value[4]), #Oxygen saturation
                                                    list(health$healthData.value[5]), #Heart rate
                                                    list(health$healthData.value[6]), #Systolic pressure
                                                    list(health$healthData.value[7]), #Diastolic pressure
                                                    list(health$healthData.value[8]), #Pulse
                                                    list(health$healthData.value[9]), #EMG
                                                    list(health$healthData.value[10]), #Skin conductance
                                                    list(health$healthData.value[11]), #Skin resistance
                                                    list(health$healthData.value[12]), #Skin conductance voltage
                                                    list(health$healthData.value[13])  #Glycose level
                                                    )),
                                                    list(1,2,3,4,5,6,7,8,9,10,11,12,13))
  })
  
}
shinyApp(ui, server)
