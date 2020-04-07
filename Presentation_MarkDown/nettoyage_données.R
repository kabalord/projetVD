library(dplyr)
library(tidyverse)
library(lattice)
library(car)

setwd("C:/Users/HP/Desktop/Visualisation/Data")
Football <- read.csv2("soccer-players-statistics.csv", sep = ",")

data.Football <- Football[1:150,-c(3:4,7:9,14,16:17,19,25:26,30,40,45:46,48)]
#------------------------------------------------------------------------------------------------------------#
data.Football$GK_Positioning <- as.integer(rowMeans(data.Football[,c("GK_Positioning",
                                                                         "GK_Diving",
                                                                         "GK_Kicking",
                                                                         "GK_Handling",
                                                                         "GK_Reflexes")]))
data.Football$GK_Diving <- data.Football$GK_Kicking <- 
  data.Football$GK_Handling <- data.Football$GK_Reflexes <- NULL
#------------------------------------------------------------------------------------------------------------#
data.Football$Sliding_Tackle <- as.integer(rowMeans(data.Football[,c("Marking","Sliding_Tackle","Standing_Tackle")]))
data.Football$Standing_Tackle <- data.Football$Marking <- NULL
#------------------------------------------------------------------------------------------------------------#
data.Football$Acceleration <- as.integer(rowMeans(data.Football[,c("Acceleration","Speed")]))
data.Football$Speed <- NULL
#------------------------------------------------------------------------------------------------------------#
data.Football$Long_Pass <- as.integer(rowMeans(data.Football[,c("Short_Pass","Long_Pass")]))
data.Football$Short_Pass <- NULL
#------------------------------------------------------------------------------------------------------------#
data.Football$Dribbling <- as.integer(rowMeans(data.Football[,c("Dribbling","Ball_Control")]))
data.Football$Ball_Control <- NULL
#------------------------------------------------------------------------------------------------------------#
data.Football$Attacking_Position <- as.integer(rowMeans(data.Football[,c("Attacking_Position","Finishing","Penalties")]))
data.Football$Penalties <- data.Football$Finishing <- NULL
#------------------------------------------------------------------------------------------------------------#
data.Football$Shot_Power <- as.integer(rowMeans(data.Football[,c("Shot_Power","Long_Shots")]))
data.Football$Long_Shots <- data.Football$Finishing <- NULL
#------------------------------------------------------------------------------------------------------------#

data.Football <- as.tibble(data.Football)
colnames(data.Football) <- c("Nom","Nationalite","Club","Position","Evaluation",
                        "Taille_en_cm","Poids_en_kg","Pied_Fort","Age","Pied_Faible",
                        "Dribbles","Defense","Attaque","Interception","Vision_du_Jeu",
                        "Centre","Passe","Rapidite","Endurance","Force","Equilibre",
                        "Agilite","Tete","Frappe","Competence_Gardien")

#
data.Football$Nationalite <- as.factor(str_to_upper(data.Football$Nationalite))
data.Football$Club <- as.factor(str_to_upper(data.Football$Club))
data.Football$Pied_Faible <- as.character(str_to_upper(data.Football$Pied_Faible))
data.Football$Pied_Faible <- as.factor(str_to_upper(data.Football$Pied_Faible))
data.Football$Nom <- str_to_upper(data.Football$Nom)
data.Football$Taille_en_cm <- as.integer(gsub("[^0-9{,}]","",data.Football$Taille_en_cm))
data.Football$Poids_en_kg <- as.integer(gsub("[^0-9{,}]","",data.Football$Poids_en_kg))

#
data.Football$Position <- as.character(str_to_upper(data.Football$Position))
data.Football$Position[data.Football$Position == 'CF'] <- 'ATTAQUANT'
data.Football$Position[data.Football$Position == 'ST'] <- 'ATTAQUANT'
data.Football$Position[data.Football$Position == 'LS'] <- 'ATTAQUANT'
data.Football$Position[data.Football$Position == 'RS'] <- 'ATTAQUANT'
data.Football$Position[data.Football$Position == 'LW'] <- 'AILIER'
data.Football$Position[data.Football$Position == 'RW'] <- 'AILIER'
data.Football$Position[data.Football$Position == 'LAM'] <- 'AILIER'
data.Football$Position[data.Football$Position == 'RAM'] <- 'AILIER'
data.Football$Position[data.Football$Position == 'CAM'] <- 'MILIEUX OFFENSIF'
data.Football$Position[data.Football$Position == 'LM'] <- 'MILIEUX GAUCHE'
data.Football$Position[data.Football$Position == 'LF'] <- 'MILIEUX GAUCHE'
data.Football$Position[data.Football$Position == 'RM'] <- 'MILIEUX DROIT'
data.Football$Position[data.Football$Position == 'RF'] <- 'MILIEUX DROIT'
data.Football$Position[data.Football$Position == 'LCM'] <- 'MILIEUX CENTRAL'
data.Football$Position[data.Football$Position == 'RCM'] <- 'MILIEUX CENTRAL'
data.Football$Position[data.Football$Position == 'CM'] <- 'MILIEUX CENTRAL'
data.Football$Position[data.Football$Position == 'LDM'] <- 'MILIEUX DEFENSIF'
data.Football$Position[data.Football$Position == 'RDM'] <- 'MILIEUX DEFENSIF'
data.Football$Position[data.Football$Position == 'CDM'] <- 'MILIEUX DEFENSIF'
data.Football$Position[data.Football$Position == 'LWB'] <- 'DEFENSEUR GAUCHE'
data.Football$Position[data.Football$Position == 'LB'] <- 'DEFENSEUR GAUCHE'
data.Football$Position[data.Football$Position == 'RWB'] <- 'DEFENSEUR DROIT'
data.Football$Position[data.Football$Position == 'RB'] <- 'DEFENSEUR DROIT'
data.Football$Position[data.Football$Position == 'LCB'] <- 'DEFENSEUR CENTRE'
data.Football$Position[data.Football$Position == 'RCB'] <- 'DEFENSEUR CENTRE'
data.Football$Position[data.Football$Position == 'CB'] <- 'DEFENSEUR CENTRE'
data.Football$Position[data.Football$Position == 'GK'] <- 'GARDIEN'

#
data.Football$Pied_Fort <- as.character(str_to_upper(data.Football$Pied_Fort))
data.Football$Pied_Fort[data.Football$Pied_Fort == "RIGHT"] <- "DROIT"
data.Football$Pied_Fort[data.Football$Pied_Fort == "LEFT"] <- "GAUCHE"
data.Football$Pied_Fort <- as.factor(str_to_upper(data.Football$Pied_Fort))

res <- filter(data.Football,Position == "RES")
data.Football$Position[data.Football$Nom == "MATTIA PERIN"] <- "GARDIEN"
data.Football$Position[data.Football$Nom == "GIACOMO BONAVENTURA"] <- "MILIEUX CENTRAL"
res <- NULL

sub <- filter(data.Football,Position == "SUB")
data.Football$Position[data.Football$Nom == c("FRANCK RIBERY","NICOLAS GAITAN")] <- "AILIER"
data.Football$Position[data.Football$Nom == "ARDA TURAN"] <- "AILIER"
data.Football$Position[data.Football$Nom == "ANDRE GOMES"] <- "MILIEUX CENTRAL"
data.Football$Position[data.Football$Nom == "DANI ALVES"] <- "DEFENSEUR DROIT"
data.Football$Position[data.Football$Nom == "CASEMIRO"] <- "MILIEUX DEFENSIF"
data.Football$Position[data.Football$Attaque >= 72 & data.Football$Position == "SUB"] <- "MILIEUX CENTRAL"
data.Football$Position[data.Football$Competence_Gardien >= 81 & data.Football$Position == "SUB"] <- "GARDIEN"
data.Football$Position[data.Football$Vision_du_Jeu >= 83 & data.Football$Position == "SUB"] <- "GARDIEN"
data.Football$Position[data.Football$Defense >= 81 & data.Football$Position == "SUB"] <- "DEFENSEUR CENTRE"
data.Football$Position[data.Football$Dribbles >= 86 & data.Football$Position == "SUB"] <- "MILIEUX OFFENSIF"
sub <- NULL

#
data.Football$Position <- as.factor(str_to_upper(data.Football$Position))
#
str(data.Football)
summary(data.Football)

colnames(data.Football)

write.table(data.Football, "../projetVD/Presentation_MarkDown/data_football.csv", row.names=FALSE, sep=",")


