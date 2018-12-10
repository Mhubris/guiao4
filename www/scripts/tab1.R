TAB1<- tabPanel("Exercicio 1",
         
         # Sidebar layout with input and output definitions ----
         sidebarLayout(
           
           # Sidebar panel for inputs ----
         sidebarPanel(
           h2("Alterações Dos Parámetros"),
           helpText("Nos sliders seguintes pode-se alterar os valore de b e a da distribuição Beta(a.b) à priori"),
           sliderInput("a", 
                       label = "a de Beta",
                       min = 1, max = 20, value=2),
           sliderInput("b", 
                       label = "b de Beta",
                       min = 1, max = 20,value=2),
           sliderInput("m", 
                       label = "Tamano da dsitribuição à priori",
                       min = 1000, max = 100000,value=1000)
         ),
           
           # Main panel for displaying outputs ----
           mainPanel(
             fluidRow(
               column(6, plotOutput(outputId = "desintyPlotPrior"),
                      fluidRow(column(6,h4("Média à Priori"),textOutput("meanp")),
                               column(6,h4("SD à Priori"),textOutput("sdp")))),
              column(6, plotOutput(outputId = "desintyPlot"),
                     fluidRow(column(6,h3("Média à Posteriori"),textOutput("meanpp")),
                              column(6,h3("SD à Posteriori"),textOutput("sdpp")))
                     ))
          )
)
)

