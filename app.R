library(shiny)
source("www/scripts/tab1.R", local=TRUE)


# Define UI ----
ui <- navbarPage(theme ="styles.css" ,"Trabalho 4",
                 tabPanel("Home",
                          fluidRow(align="center",
                                   column(6,offset = 3,
                                          img(src="fct_unl.png",width="200", style="margin-bottom:45px;margin-top:45px;"),
                                          sidebarPanel(width = 12, align="center",style="background-color:#fff;",
                                                       h1("Estatastica Numérica Computacional"),
                                                       h3("Trabalho - Grupo 4"),
                                                       h4("Bernardo Teixeira MIEBM", style="margin-top:45px !important;"),
                                                       h4("Catarina Marques  MIEBM"),
                                                       h4("Luca Silvestri    MIEI"),
                                                       h4("Miguel Andrade    MIEBM"))
                                   ))),
                 TAB1
                 
)

# Define server logic ----
server <- function(input, output) {
  output$desintyPlotPrior <- renderPlot({ 
    set.seed(32)
    x = c(1.0, 1.5, 1.5, 1.5, 2.5, 4.0, 5.0, 5.0, 7.0, 8.0, 8.5, 9.0, 9.5, 9.5, 10.0,
          12.0, 12.0, 13.0, 13.0, 14.5, 15.5, 15.5, 16.5, 17.0, 22.5, 29.0, 31.5)
    
    y = c(1.80, 1.85, 1.87, 1.77, 2.02, 2.27, 2.15, 2.26, 2.47, 2.19, 2.26, 2.40, 2.39,
          2.41, 2.50, 2.32, 2.32, 2.43, 2.47, 2.56, 2.65, 2.47, 2.64, 2.56, 2.70, 2.72, 2.57)
    m=input$m
    a=input$a
    b=input$b
    gamma = rbeta(m, a, b)
    n = length(x)
    mu = matrix(NA, nrow=n, ncol=m)
    for (i in 1:m){
      mu[,i] = 2.7 - 0.9 * (gamma[i] ^ x)
    }
    delta = colSums((y - mu)^2)
    l = exp(-delta / (2 * 0.01))
    weights = l / sum(l)
    gamma_res = sample(gamma, prob=weights, replace=T)
    output$meanp <- renderText({ 
      a/(a+b)
    })
    output$sdp <- renderText({ 
      sqrt(a *b / ((a + b) ^ 2*(a + b + 1)))
    })
    output$meanpp <- renderText({ 
     mean(gamma_res)
    })
    output$sdpp <- renderText({ 
     sd(gamma_res)
    })
    
    output$desintyPlot <- renderPlot({ 
      hist(gamma_res, prob=T)
      lines(density(gamma_res), col=2)
      })
    hist(gamma, prob=T)
    lines(density(gamma), col=2)
  })

  
}

# Run the app ----
shinyApp(ui = ui, server = server)