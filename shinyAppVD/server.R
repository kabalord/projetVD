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

# Chargement dataset
data.Football <- fread(file="data_football.csv")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    # Summary    
    output$sum <- renderPrint({
        summary(data.Football)
    })
    
    output$head <- renderPrint({
        head(data.Football[,1:4],10)
    })
    
    # value boxes accueil
    output$observations <- renderValueBox({
        valueBox(
            nrow(data.Football), icon = icon("list"), "Nombre d'observations", color = "purple")
    })
    
    output$variables <- renderValueBox({
        valueBox(
            ncol(data.Football), icon = icon("columns"), "Nombre de variables", color = "yellow")
    })
    
    output$date <- renderValueBox({
        valueBox(2017, icon = icon("calendar"),"Date d'analyse", color = "light-blue")
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
