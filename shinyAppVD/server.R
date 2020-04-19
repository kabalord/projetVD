#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(dplyr)
library(dplyr)
library(tidyverse)
library(lattice)
library(car)
library(viridis)
library(GGally)
library(plotly)
library(ggcorrplot)

# Chargement dataset
data.Football <- fread(file="data_football.csv")

# Definition des variables
GARDIEN <- filter(data.Football,Position == "GARDIEN")
DEFENSEUR <- filter(data.Football,Position == c("DEFENSEUR GAUCHE") | Position == c("DEFENSEUR DROIT") |Position == c("DEFENSEUR CENTRE"))
MILIEUX <- filter(data.Football,Position == c("MILIEUX OFFENSIF") | Position == c("MILIEUX GAUCHE") |Position == c("MILIEUX DROIT") | Position == c("MILIEUX CENTRAL") | Position == c("MILIEUX DEFENSIF"))
ATTAQUANT <- filter(data.Football,Position == c("AILIER") | Position == c("ATTAQUANT"))
Gaucher <- filter(data.Football,Pied_Fort == "GAUCHE")
Droitier <- filter(data.Football,Pied_Fort == "DROIT")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    # correlation    
    output$correlation <- renderPlot({
        ggcorr(data.Football, breaks = input$controlsCorrelation)
    })
    
    # Secteurs
    
    output$defensif <- renderPlotly({
        ggplot(data.Football, breaks = input$defensif) + 
            geom_point(aes(x = Defense, y = Interception),color ="#35b779")
    })
    
    output$offensif <- renderPlotly({
        ggplot(data.Football) + 
            geom_point(aes(x = Attaque, y = Dribbles),color ="#35b779")
    })
    
    # repartition des jouers par evaluation
    
    output$evaluation <- renderPlot({
        ggplot(data.Football) +
            aes(x = Evaluation) +
            geom_histogram(fill ="#35b779", colour = "black",binwidth = .5) + 
            geom_rug() +
            ggtitle("Repartition des joueurs par evaluation") +
            xlab("Evaluation") +
            ylab("Effectif") +
            theme_light() +
            scale_y_continuous(limits = c(0,25))
    })
    
    output$represent <- renderPlot({
        ggplot(data = data.Football) + 
            geom_histogram(aes(x = Evaluation),binwidth=.5,fill ="#35b779", colour = "black") + 
            facet_wrap(~Position)
    })
    
    # value boxes accueil
    output$observations <- renderValueBox({
        valueBox(
            nrow(data.Football), icon = icon("list-ol"), "Observations", color = "purple")
    })
    
    output$variables <- renderValueBox({
        valueBox(
            ncol(data.Football), icon = icon("columns"), "Variables", color = "teal")
    })
    
    output$date <- renderValueBox({
        valueBox(2017, icon = icon("calendar"),"Date d'analyse", color = "light-blue")
    })
    
    # value boxes tables
    output$unoTable <- renderValueBox({
        valueBox("Access", icon = icon("database"),"Database", color = "purple")
    })
    
    output$dosTable <- renderValueBox({
        valueBox("Search", icon = icon("search"),"Filtre", color = "teal")
    })
    output$tresTable <- renderValueBox({
        valueBox("Information", icon = icon("eye"),"Détaillé", color = "light-blue")
    })
    
    # value boxes graphes
    output$graphesUno <- renderValueBox({
        valueBox(2017, icon = icon("chart-bar"),"Date d'analyse", color = "purple")
    })
    
    output$graphesDos <- renderValueBox({
        valueBox(2017, icon = icon("chart-area"),"Date d'analyse", color = "teal")
    })
    output$graphesTres <- renderValueBox({
        valueBox(2017, icon = icon("chart-line"),"Date d'analyse", color = "light-blue")
    })
    
    # Summary    
    output$sum <- renderPrint({
        summary(data.Football)
    })
    
    
    # repartition   
    output$repartition <- renderPlot({
        ggplot(data = data.Football) + 
            geom_histogram(aes(x = Evaluation),binwidth=.5,fill ="#35b779", colour = "black") + 
            facet_wrap(~Position)
    })
    
    
    # graphs
    
    output$EvalPlot = renderPlot({
            data.Football%>%filter(Evaluation <= input$Slide)%>%
                ggplot(aes(Evaluation)) +
                geom_histogram(fill ="#35b779", colour = "black",binwidth = .5) +
                geom_rug() +
                ggtitle("Repartition des joueurs par evaluation") +
                xlab("Evaluation") +
                ylab("Effectif") +
                theme_light() +
                scale_y_continuous(limits = c(0,50))
        })
    
    
    output$myhist = renderPlot({
        data.Football%>%filter(Evaluation <= input$Slide & Position == input$var)%>% 
            ggplot(aes(Taille_en_cm, Poids_en_kg)) +
            geom_point(aes(colour = Position))
        })
    
    output$myhisto = renderPlot({
            data.Football%>%filter(Position == input$var)%>% 
                ggplot() + geom_bar(aes(x = Position),fill ="#35b779", colour = "black") + 
                scale_x_discrete("Position") +
                labs(x = "Position", y = "Effectif") +
                theme_gray()
        })
    
    
    output$myhist1 = renderPlot(
        {
            GARDIEN%>%filter(Taille_en_cm <= input$Slide & Poids_en_kg <= input$Slide2)%>% 
                ggplot(aes(x=Taille_en_cm, y=Poids_en_kg, colour=Position, shape=Position))+
                geom_point()
        }
    )
    output$myhist2 = renderPlot({
            DEFENSEUR%>%filter(Taille_en_cm <= input$Slide & Poids_en_kg <= input$Slide2)%>% 
                ggplot(aes(x=Taille_en_cm, y=Poids_en_kg, colour=Position, shape=Position))+
                geom_point()
        })
    output$myhist3 = renderPlot({
            MILIEUX%>%filter(Taille_en_cm <= input$Slide & Poids_en_kg <= input$Slide2)%>% 
                ggplot(aes(x=Taille_en_cm, y=Poids_en_kg, colour=Position, shape=Position))+
                geom_point()
        })
    output$myhist4 = renderPlot({
            ATTAQUANT%>%filter(Taille_en_cm <= input$Slide & Poids_en_kg <= input$Slide2)%>% 
                ggplot(aes(x=Taille_en_cm, y=Poids_en_kg, colour=Position, shape=Position))+
                geom_point()
        })

    # tables
    
    output$gardiens<- DT::renderDataTable({
        (GARDIEN[,1:5])
    })
    
    output$defenseurs <- DT::renderDataTable({
        (DEFENSEUR[,1:5])
    })
    
    output$milieux <- DT::renderDataTable({
        (MILIEUX[,1:5])
    })
    
    output$attaquants <- DT::renderDataTable({
        (ATTAQUANT[,1:5])
    })
    
    output$msgOutput <- renderMenu({
        msgs <- apply(read.csv("messages.csv"), 1, function(row){
            messageItem(from = row[["from"]], message = row[["message"]])
        })
        dropdownMenu(type = "messages", .list = msgs)
    })
    
    output$performance <- renderInfoBox({
        infoBox("Performance :", "100%", icon = icon("chart-bar"))
    })
    
    output$itemRequested <- renderValueBox({
        valueBox(15*300, "Item Request by Jouers", icon = icon("fire"), color = "yellow")
    })
})
