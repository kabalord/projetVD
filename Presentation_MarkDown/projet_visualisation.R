library(dplyr)
library(tidyverse)
library(lattice)
library(car)
library(viridis)
library(GGally)

setwd("C:/Users/HP/Desktop/Visualisation/ProjetVD/Presentation_MarkDown")
data.Football <- read.csv2("data_football.csv", sep = ",")
str(data.Football)

#ggpairs(data.Football[, c("Competence_Gardien","Competence_Defense","Competence_Milieux","Competence_Attaque")], aes(color = data.Football$Pied_Fort))

colnames(data.Football)


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

#x <- ggplot(data.Football) +
#  aes(x = Passe_Longue, fill = Position) +
#  geom_bar() +
#  geom_text(aes(label = ..count..), stat = "count", position = position_stack(.5)) +
#  xlab("Passe_Longue") +
#  ylab("Effectifs") +
#  labs(fill = "Position")

#ggsave("mon_graphique.pdf", plot = x,
#       width = 11, height = 8)

Mat <- data.Football[,c("Nom","Evaluation","Position")]
Mat$Equipe <- sample(1:dim(Mat)[1],150)
GARDIEN_Equipe <- filter(Mat,Position == "GARDIEN")
DEFENSEUR_Equipe <- filter(Mat,Position == c("DEFENSEUR GAUCHE") | Position == c("DEFENSEUR DROIT") |Position == c("DEFENSEUR CENTRE"))
MILIEUX_Equipe <- filter(Mat,Position == c("MILIEUX OFFENSIF") | Position == c("MILIEUX GAUCHE") |Position == c("MILIEUX DROIT") | Position == c("MILIEUX CENTRAL") | Position == c("MILIEUX DEFENSIF"))
ATTAQUANT_Equipe <- filter(Mat,Position == c("AILIER") | Position == c("ATTAQUANT"))

creation.equipe <- function(G,D,M,A){
  x <- cbind(sample(G$Nom,16),sample(D$Nom,16),sample(M$Nom,16),sample(A$Nom,16))
  return (x);
}


Mat2 <- creation.equipe(GARDIEN_Equipe,DEFENSEUR_Equipe,
                MILIEUX_Equipe,ATTAQUANT_Equipe)

Mat2 <- merge(Mat2,Mat,by.x="Nom",by.y="Nom")
