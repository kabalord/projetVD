library(dplyr)
library(tidyverse)
library(lattice)
library(car)
library(viridis)
library(GGally)

setwd("C:/Users/HP/Desktop/Visualisation/ProjetVD/Presentation_MarkDown")
data.Football <- read.csv2("data_football.csv", sep = ",")

ggplot(filter(data.Football,Position == "ATTAQUANT")) + geom_text(aes(x = Finition, y = Attaque, label = Nom), 
                                                                  color = "darkred", size = 2)




remplacer.id.nom <- function(data,x){
  for (i in x) {
    
  }
}

creation.equipe <- function(data,n){
  x <- c(0)
  for (i in 1:n) {
    y <- c(sample(1:dim(data1)[1],5))
    x <- c(x,y)
  }
  x <- x[-1]
  
  for (i in x) {
    for (j in 1:5) {
      
    }
  }
  return(x)
}


data1 <- data.Football


for (i in 2) {
  y <- c(0)
  x <- list(c(0))
  for (i in 1:5) {
    y <- c(y,sample(1:dim(data1)[1],5))
    x <- list(x,y)
    data1 <- data1[-c(x[[i+1]][1]),]
  }
}
x
