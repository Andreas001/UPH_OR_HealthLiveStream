library(shiny)
library(plotly)
library(shinyjs)
#UI FILE------------------
ui <- fluidPage(
  # includeCSS("styles.css"),
  
  headerPanel(h1("LIVE iHealth Tracker - James Adhitthana", align = "center")),
  br(),
  div(h5("Click on the right side of the table to enable/disable viewing a sensor's graph"), align = "center"),
  div(h6("Live data is streamed from http://ihealth.sepdek.net/"), align = "center"),
  br(),
  div(plotlyOutput("plot"), id='graph'),
  useShinyjs()
)
#//------------//

#SERVER FILE------------------
server <- function(input, output, session) {
  library(jsonlite)
  jsSepdek = fromJSON("http://ihealth.sepdek.net/")
  jamesHealth <- as.data.frame(jsSepdek)
  
  values <- reactiveValues()
  
  values$p <- plot_ly(
    type = 'scatter',
    mode = 'lines'
  ) %>%
    
    #Row 1:
    add_trace(
      name = jamesHealth$healthData.sensor[1],
      y = c(jamesHealth$healthData.value[1]),
      line = list(
        color = '#266dd3',
        width = 3
      )
    ) %>%
    #-----------

    #Row 2:
    add_trace(
      name = jamesHealth$healthData.sensor[2],
      y = c(jamesHealth$healthData.value[2]),
      line = list(
        color = '#344055',
        width = 3
      )
    ) %>%
    #-----------
  
    #Row 3:
    add_trace(
    name = jamesHealth$healthData.sensor[3],
    y = c(jamesHealth$healthData.value[3]),
    line = list(
      color = '#888098',
      width = 3
    )
  ) %>%
    #-----------
  
  #Row 4:
  add_trace(
    name = jamesHealth$healthData.sensor[4],
    y = c(jamesHealth$healthData.value[4]),
    line = list(
      color = '#cfb3cd',
      width = 3
    )
  ) %>%
    #-----------
  
  #Row 5:
  add_trace(
    name = jamesHealth$healthData.sensor[5],
    y = c(jamesHealth$healthData.value[5]),
    line = list(
      color = '#cfb3cd',
      width = 3
    )
  ) %>%
    #-----------
  
  
  #Row 6:
  add_trace(
    name = jamesHealth$healthData.sensor[6],
    y = c(jamesHealth$healthData.value[6]),
    line = list(
      color = '#00bfb2',
      width = 3
    )
  ) %>%
    #-----------
  
  
  #Row 7:
  add_trace(
    name = jamesHealth$healthData.sensor[7],
    y = c(jamesHealth$healthData.value[7]),
    line = list(
      color = '#1a5e63',
      width = 3
    )
  ) %>%
    #-----------
  
  #Row 8:
  add_trace(
    name = jamesHealth$healthData.sensor[8],
    y = c(jamesHealth$healthData.value[8]),
    line = list(
      color = '#028090',
      width = 3
    )
  ) %>%
    #-----------
  
  #Row 9:
  add_trace(
    name = jamesHealth$healthData.sensor[9],
    y = c(jamesHealth$healthData.value[9]),
    line = list(
      color = '#f0f3bd',
      width = 3
    )
  ) %>%
    #-----------
  
  #Row 10:
  add_trace(
    name = jamesHealth$healthData.sensor[10],
    y = c(jamesHealth$healthData.value[10]),
    line = list(
      color = '#c64191',
      width = 3
    )
  ) %>%
    #-----------
  
  #Row 11:
  add_trace(
    name = jamesHealth$healthData.sensor[11],
    y = c(jamesHealth$healthData.value[11]),
    line = list(
      color = '#d0db97',
      width = 3
    )
  ) %>%
    #-----------
  
  #Row 12:
  add_trace(
    name = jamesHealth$healthData.sensor[12],
    y = c(jamesHealth$healthData.value[12]),
    line = list(
      color = '#69b578',
      width = 3
    )
  ) %>%
    #-----------
  
  #Row 13:
  add_trace(
    name = jamesHealth$healthData.sensor[13],
    y = c(jamesHealth$healthData.value[13]),
    line = list(
      color = '#3a7d44',
      width = 3
    )
  ) %>%
    #-----------
    layout(
      yaxis = list(title = "Sensors"),
      xaxis = list(title = "Seconds Passed")
    )
  output$plot <- renderPlotly({values$p})
  
  observe({
    invalidateLater(1000, session)
    jsSepdek = fromJSON("http://ihealth.sepdek.net/")
    jamesHealth <- as.data.frame(jsSepdek)
    
    
    plotlyProxy("plot", session) %>%
      plotlyProxyInvoke("extendTraces", list(y=list(list(jamesHealth$healthData.value[1]), #Row 1
                                                    list(jamesHealth$healthData.value[2]), #Row 2
                                                    list(jamesHealth$healthData.value[3]), #Row 3
                                                    list(jamesHealth$healthData.value[4]), #Row 4
                                                    list(jamesHealth$healthData.value[5]), #Row 5
                                                    list(jamesHealth$healthData.value[6]), #Row 6
                                                    list(jamesHealth$healthData.value[7]), #Row 7
                                                    list(jamesHealth$healthData.value[8]), #Row 8
                                                    list(jamesHealth$healthData.value[9]), #Row 9
                                                    list(jamesHealth$healthData.value[10]), #Row 10
                                                    list(jamesHealth$healthData.value[11]), #Row 11
                                                    list(jamesHealth$healthData.value[12]), #Row 12
                                                    list(jamesHealth$healthData.value[13])  )),list(1,2,3,4,5,6,7,8,9,10,11,12,13))
  })
  
}
shinyApp(ui, server)