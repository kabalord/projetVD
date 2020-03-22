library(dplyr)
library(tidyverse)
library(lattice)
library(car)
library(viridis)
library(GGally)

setwd("C:/Users/HP/Desktop/Visualisation/ProjetVD/Presentation_MarkDown")
data.Football <- read.csv2("data_football.csv", sep = ",")







ggplot(data.Football) + geom_bar(aes(x = Position)) + 
  scale_x_discrete("Position")#, limits = c("ATTAQUANT","AILIER","MILIEUX OFFENSIF","MILIEUX GAUCHE","MILIEUX DROIT")
ggplot(data = data.Football) + 
  geom_histogram(aes(x = Evaluation)) + 
  facet_wrap(~Position)
ggplot(data.Football, aes("", fill = factor(Pied_Fort))) + 
  geom_bar(aes(y = (..count..)/sum(..count..)), width = 1) +
  scale_y_continuous() +
  ylab("") + xlab("") + labs(fill = "Pied_Fort") +
  theme(axis.ticks = element_blank()) + 
  coord_polar(theta = "y")
ggplot(data.Football) +
  aes(x = Passe_Longue, fill = Position) +
  geom_bar() +
  geom_text(aes(label = ..count..), stat = "count", position = position_stack(.5)) +
  xlab("Passe_Longue") +
  ylab("Effectifs") +
  labs(fill = "Position")







ggplot(data.Football) + 
  geom_point(aes(x = Finition, y = Attaque), 
             color = "red", size = 1) +
  scale_x_continuous("Note en finition",limits = c(0,100)) +
  scale_y_continuous("Note en attaque",limits = c(0,100))
ggplot(filter(data.Football,Position == "ATTAQUANT")) + geom_text(aes(x = Finition, y = Attaque, label = Nom), 
                                                                  color = "darkred", size = 2)





ggplot(data = data.Football, aes(x = Passe_Longue, y = Passe_Courte)) + 
  geom_point(alpha = 0.2) + 
  geom_text(data = filter(data.Football,Position == "MILIEUX CENTRAL"), aes(label = Nom), color = "red", size = 3)

ggplot(data.Football, aes(x = Passe_Courte)) + 
  geom_histogram(aes(y = ..density..), binwidth = 2) +
  geom_density()

ggplot(data.Football, aes(Passe_Courte, Passe_Longue)) + geom_point() +
  geom_rug() +
  geom_smooth(method = "lm")

ggplot(data.Football, aes(Passe_Courte, col = factor(Pied_Fort))) +
  geom_density()

#Ensemble
ggplot(data.Football, aes(factor(Pied_Fort), Passe_Courte, fill = factor(Pied_Fort))) +
  geom_boxplot()
ggplot(data.Football, aes(factor(Pied_Fort), Passe_Courte)) + 
  geom_jitter()
ggplot(data.Football, aes(factor(Pied_Fort), Passe_Courte)) + 
  geom_boxplot() +
  geom_jitter()

x <- ggplot(data.Football) +
  aes(x = Passe_Longue, fill = Position) +
  geom_bar() +
  geom_text(aes(label = ..count..), stat = "count", position = position_stack(.5)) +
  xlab("Passe_Longue") +
  ylab("Effectifs") +
  labs(fill = "Position")

ggsave("mon_graphique.pdf", plot = x,
       width = 11, height = 8)
