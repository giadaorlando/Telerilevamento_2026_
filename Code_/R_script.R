# First R script

2+3
#oggetti e assegnazione
michele <- 2+3 #prendo quello che è a destra e lo associo a ciò che c'è a sinistra
michele = 2+3 # in questo caso la relazione è bilaterale

tecla <- 4+6

#tutte le operazioni con i miei oggetti
michele^tecla

#arrays o vettori
sonia<- c(10, 8, 3, 1, 0) #funzione e argomenti della funzione, scrivendo nome funzione e traparentesi gli argomenti

gigio<- c(3,10,20,50,100)

plot(gigio, sonia, col="blue",pch=19, cex=2) #variabile indipendente sulle x
plot(gigio, sonia, col="blue",pch=19, cex=2, xlab="pollution", ylab="numero delfini")

#Installazione pacchetti
#CRAN
install.packages("terra")
library(terra)

#GitHub
install.packages("devtools")
library(devtools)
install_github("ducciorocchini/imageRy")

library(imageRy)

