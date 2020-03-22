library(dplyr)
library(tidyverse)
library(lattice)
library(car)

setwd("C:/Users/HP/Desktop/Visualisation/Data")
Football <- read.csv2("soccer-players-statistics.csv", sep = ",")
data.Football <- as.tibble(Football[1:300,-c(3:4,7:9,14,16:17)])

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
data.Football$Pied_Fort <- as.factor(str_to_upper(data.Football$Pied_Fort))
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
write.table(data.Football, "../data_football.csv", row.names=FALSE, sep=",")

#Clubs <- unique(data.Football[1:634,"Club"])
#Clubs <- Clubs[-c(18,21:23,25:28,32,34:38,40,42:50,52,55:83,86:108),]
#sink(clubs)
#vide <- filter(data.Football,Position == "")

#----------------------------------------------------------------------------------------------------------------#
ggplot(data.Football) + 
  geom_point(aes(x = Dribbles, y = Finition, color = Attaque))

ggplot(data.Football) + 
  geom_point(aes(x = Finition, y = Attaque, color = Vitesse)) + 
  scale_color_gradient("Taux de joueur rapide", low = "blue", high = "green")

ggplot(data.Football) + 
  geom_point(aes(x = Finition, y = Attaque, color = Vitesse)) + 
  scale_color_viridis("Taux de joueur rapide", option = "plasma")

ggplot(data.Football) + 
  geom_point(aes(x = Finition, y = Attaque, color = Vitesse)) + 
  scale_color_distiller("Taux de joueur rapide", palette = "Spectral")

ggplot(data.Football) + 
  geom_point(aes(x = Finition, y = Attaque, color = Position))

ggplot(data.Football) + 
  geom_point(aes(x = Finition, y = Attaque, color = Pied_Fort)) +
  scale_color_manual("Pied_Fort", 
                     values = c("red", "#FFDD45", rgb(0.1,0.2,0.6), "darkgreen", "grey80"))

ggplot(data.Football) + 
  geom_point(aes(x = Finition, y = Attaque, color = Position)) +
  scale_color_brewer("Position", palette = "Paired")

ggplot(data.Football) + 
  geom_histogram(aes(x = Tacle_Debout)) + 
  ggtitle("Titre") +
  xlab("Pourcentage de teacle debout") +
  ylab("Effectif")

ggplot(data.Football) +
  aes(x = Position, y = Evaluation) +
  geom_boxplot(fill = "#0c4c8a") +
  theme_minimal()

ggplot(data.Football) +
  aes(x = Age, y = Evaluation) +
  geom_point() +
  xlab("Âge") +
  ylab("Evaluation")

ggplot(data.Football) +
  aes(x = Evaluation) +
  geom_histogram(fill ="orange", colour = "black") + #binwidth = 2
  geom_rug() +
  ggtitle("Titre") +
  xlab("Evaluation") +
  ylab("Effectifs")

ggplot(data.Football) +
  aes(x = Evaluation) +
  geom_density(adjust = 1.5) +
  ggtitle("Titre") +
  xlab("Attaque") +
  ylab("Densité")

ggplot(data.Football) +
  aes(x = Age, y = Position) +
  geom_boxplot() +
  xlab("Evaluation") +
  ylab("Âge") +
  ggtitle("Répartition par âge selon le poste")

ggplot(data.Football) +
  aes(x = Position, y = Evaluation) +
  geom_boxplot() +
  xlab("Position") +
  ylab("Evaluation") +
  ggtitle("Répartition par âge selon l'evaluation")

ggplot(data.Football) +
  aes(x = Position) +
  geom_bar() +
  xlab("Position") +
  ylab("Effectifs")

ggplot(data.Football) +
  aes(x = Passe_Courte, y = Passe_Longue) +
  geom_smooth(method = "lm") +
  geom_point() +
  xlab("Position") +
  ylab("Passe longue")

ggpairs(data.Football[, c("Passe_Courte", "Passe_Longue", "Controle_de_balle", "Pied_Fort")], aes(colour = Pied_Fort))

ggcorr(data.Football)


#ggplot(data.Football) + geom_label(aes(x = Tacle_Debout, y = Agressivite, label = Nom))
#library(leaflet)
#leaflet(data = data.Football) %>%
#  addTiles %>%
#  addCircles(lng=~lon, lat=~lat, radius=~n * 10, popup=~Nom)
#RColorBrewer::display.brewer.all()
#corrgram(data.Football, lower.panel=panel.cor,upper.panel=panel.pie, text.panel=panel.txt)
#boxplot(Evaluation~Nationalite,data=data.Football,xlab="Poste",ylab="Évaluation")
#ggplot(data = data.Football) + 
#geom_histogram(aes(x = Evaluation)) + 
#facet_grid(Position~Attaque)
#ggplot(data = data.Football) + 
#geom_histogram(aes(x = Evaluation)) + 
#facet_grid(.~Position)
#ggplot(data.Football) + geom_bar(aes(x = Position, fill = Attaque))
#ggplot(data.Football) + geom_line(aes(x = Pied_Fort, y = Evaluation))
#ggplot(data.Football) + geom_density(aes(x = Tacle_Debout, bw = 1))
#ggplot(data.Football) + geom_density(aes(x = Tacle_Debout))
#scatterplot(Evaluation~Age, data=data.Football,xlab="", ylab="Évaluation", main="Évaluation Vs. Age",col="red")
#scatterplot(Tacle_Debout~Passe_Longue, data=data.Football,xlab="", ylab="Tacle debout", main="Tacle debout Vs. Passe longue")

#ggplot(data.Football) + 
#  geom_point(aes(x = Attaque, y = Dribbles, color = Position, label = Nom))#alpha = Endurance, size = Vitesse

#ggplot(data.Football) + 
#  geom_boxplot(aes(x = Position, y = Attaque)) + 
#  geom_point(aes(x = Position, y = Attaque), col = "red", alpha = 0.2)

#ggplot(data.Football,aes(x = Position, y = Attaque)) + 
#  geom_boxplot() + 
#  geom_jitter(col = "red", alpha = 0.2)

#ggplot(data.Football, aes(x = Finition, y = Attaque)) + 
#  geom_point(alpha = 0.2,col = "red") + 
#  geom_density2d(color = "red") + 
#  geom_smooth(method = "lm")

#c("Nom","Nationalite","Club","Position","Evaluation",
#  "Taille_en_cm","Poids_en_kg","Pied_Fort","Age","Pied_Faible",
#  "Geste_Technique","Controle_de_balle","Dribbles","Marquage","Tacle_Glisse",
#  "Tacle_Debout","Agressivite","Reaction","Attaque","Interception",
#  "Vision_du_Jeu","Calme","Centre","Passe_Courte","Passe_Longue","Acceleration",
#  "Vitesse","Endurance","Force","Equilibre","Agilite","Jump","Tete","Puissance_de_Frappe",
#  "Finition","Frappe_de_Loin","Curve","Précision_du_Coup_Franc","Penalty","Volley","Positionnement_GK",
#  "Plongee_GK","Coup_de_pied_GK","Jeu_de_Main_GK","Reflexes_GK")

#filter(data.Football[,1:4],Position == "GARDIEN")
#filter(data.Football[,1:4],Position == c("DEFENSEUR GAUCHE","DEFENSEUR DROIT","DEFENSEUR CENTRE"))
#filter(data.Football[,1:4],Position == c("MILIEUX OFFENSIF","MILIEUX GAUCHE","MILIEUX DROIT","MILIEUX CENTRAL","MILIEUX DEFENSIF"))
#filter(data.Football[,1:4],Position == "ATTAQUANT")
