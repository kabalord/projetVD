library(dplyr)
library(tidyverse)
library(lattice)
library(car)

setwd("C:/Users/HP/Desktop/Visualisation/Data")
Football <- read.csv2("soccer-players-statistics.csv", sep = ",")
data.Football <- as.tibble(Football[1:150,-c(3:4,7:9,14,16:17)])

colnames(data.Football) <- c("Nom","Nationalite","Club","Position","Evaluation",
                        "Taille_en_cm","Poids_en_kg","Pied_Fort","Age","Pied_Faible",
                        "Geste_Technique","Controle_de_balle","Dribbles","Marquage","Tacle_Glisse",
                        "Tacle_Debout","Agressivite","Reaction","Attaque","Interception",
                        "Vision_du_Jeu","Calme","Centre","Passe_Courte","Passe_Longue","Acceleration",
                        "Vitesse","Endurance","Force","Equilibre","Agilite","Jump","Tete","Puissance_de_Frappe",
                        "Finition","Frappe_de_Loin","Curve","Precision_du_Coup_Franc","Penalty","Volley","Positionnement_GK",
                        "Plongee_GK","Coup_de_pied_GK","Jeu_de_Main_GK","Reflexes_GK")


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
data.Football$Position[data.Football$Nom == "OSCAR"] <- "MILIEUX OFFENSIF"
res <- NULL
sub <- filter(data.Football,Position == "SUB")
data.Football$Position[data.Football$Finition >= 81 & data.Football$Position == "SUB"] <- "ATTAQUANT"
data.Football$Position[data.Football$Reflexes_GK >= 82 & data.Football$Position == "SUB"] <- "GARDIEN"
data.Football$Position[data.Football$Acceleration >= 79 & data.Football$Dribbles >= 80 & data.Football$Position == "SUB"] <- "AILIER"
data.Football$Position[data.Football$Nom == "SHINJI KAGAWA"] <- "MILIEUX OFFENSIF"
data.Football$Position[data.Football$Nom == "DANI ALVES"] <- "DEFENSEUR DROIT"
data.Football$Position[data.Football$Nom == "SERGE AURIER"] <- "DEFENSEUR DROIT"
data.Football$Position[data.Football$Nom == "ALESSANDRO FLORENZI"] <- "DEFENSEUR DROIT"
data.Football$Position[data.Football$Nom == "KAKA"] <- "MILIEUX OFFENSIF"
data.Football$Position[data.Football$Nom == "AXEL WITSEL"] <- "MILIEUX CENTRAL"
data.Football$Position[data.Football$Passe_Longue >= 81 & data.Football$Agilite < 86 & data.Football$Position == "SUB"] <- "MILIEUX CENTRAL"
data.Football$Position[data.Football$Endurance >= 88  & data.Football$Endurance <= 90 & data.Football$Position == "SUB"] <- "MILIEUX CENTRAL"
data.Football$Position[data.Football$Dribbles >= 83 & data.Football$Position == "SUB"] <- "MILIEUX OFFENSIF"
data.Football$Position[data.Football$Marquage >= 79 & data.Football$Position == "SUB"] <- "DEFENSEUR CENTRE"
sub <- NULL

#
data.Football$Position <- as.factor(str_to_upper(data.Football$Position))
#
str(data.Football)
summary(data.Football)

#
data.Football$Competence_Gardien <- as.integer(rowMeans(data.Football[,c("Plongee_GK",
                                                                         "Coup_de_pied_GK",
                                                                         "Jeu_de_Main_GK",
                                                                         "Reflexes_GK",
                                                                         "Positionnement_GK")]))
data.Football$Plongee_GK <- data.Football$Coup_de_pied_GK <- 
  data.Football$Jeu_de_Main_GK <- data.Football$Reflexes_GK <-
  data.Football$Positionnement_GK <- NULL

data.Football$Competence_Defense <- as.integer(rowMeans(data.Football[,c("Interception",
                                                                         "Marquage",
                                                                         "Tacle_Glisse",
                                                                         "Tacle_Debout",
                                                                         "Force",
                                                                         "Agressivite")]))
data.Football$Marquage <- data.Football$Tacle_Glisse <- 
  data.Football$Tacle_Debout <- data.Football$Interception <- data.Football$Force <-
  data.Football$Agressivite <- NULL

data.Football$Competence_Milieux <- as.integer(rowMeans(data.Football[,c("Frappe_de_Loin",
                                                                         "Endurance",
                                                                         "Controle_de_balle",
                                                                         "Dribbles",
                                                                         "Calme",
                                                                         "Passe_Courte",
                                                                         "Passe_Longue",
                                                                         "Vision_du_Jeu",
                                                                         "Equilibre",
                                                                         "Precision_du_Coup_Franc")]))
data.Football$Frappe_de_Loin <- data.Football$Endurance <- data.Football$Controle_de_balle <-
  data.Football$Dribbles <- data.Football$Calme <- 
  data.Football$Passe_Courte <- data.Football$Passe_Longue <-
  data.Football$Vision_du_Jeu <- data.Football$Equilibre <-
  data.Football$Precision_du_Coup_Franc <- NULL

data.Football$Competence_Attaque <- as.integer(rowMeans(data.Football[,c("Volley",
                                                                         "Curve",
                                                                         "Finition",
                                                                         "Puissance_de_Frappe",
                                                                         "Tete",
                                                                         "Jump",
                                                                         "Agilite",
                                                                         "Vitesse",
                                                                         "Acceleration",
                                                                         "Geste_Technique",
                                                                         "Attaque",
                                                                         "Reaction",
                                                                         "Centre",
                                                                         "Penalty")]))
data.Football$Volley <- data.Football$Curve <- 
  data.Football$Finition <- data.Football$Puissance_de_Frappe <-
  data.Football$Tete <- data.Football$Jump <- 
  data.Football$Agilite <- data.Football$Vitesse <-
  data.Football$Acceleration <- data.Football$Geste_Technique <- 
  data.Football$Attaque <- data.Football$Reaction <-
  data.Football$Centre <- data.Football$Penalty <- NULL

write.table(data.Football, "../projetVD/Presentation_MarkDown/data_football.csv", row.names=FALSE, sep=",")

#Clubs <- unique(data.Football[1:634,"Club"])
#Clubs <- Clubs[-c(18,21:23,25:28,32,34:38,40,42:50,52,55:83,86:108),]
#sink(clubs)
#vide <- filter(data.Football,Position == "")

