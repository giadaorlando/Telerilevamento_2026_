#code for classifocare data

library(terra)
library(imageRy)
library(ggplot2)



im.list()
sun <- im.import("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")
#classify
sunc <- im.classify(sun, num_clusters=3)
sunc <- im.classify(sun, seed=3) #seed serve per scegliere una delle possibili interazioni
sunc <- im.classify(sun, seed=42)

can<- im.import("dolansprings_oli_2013088_canyon_lrg.jpg")
cancc <- im.classify(can, seed=42, num_clusters=4) #devo scegliere io quante classi mettere 
ncell.(can) #per sapere il numero di pixel di un'immagine

setwd("C:/Users/Giada/OneDrive/Documenti/doc UNIBO/immagini telerilevamento")
list.files()
sal<- rast("salento-torre-dell-orso-1000x650.jpg")
sal <-flip(sal)
plot(sal)
salc <- im.classify(sal, num_clusters=3)

#matogrosso esempio
m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")
m1992 <- flip(m1992)
m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")
m2006 <- flip(m2006)
im.multiframe(1,2)
plot(m1992)
plot(m2006)

m1992c<-im.classify(m1992, seed=42, num_cluster=2)
levels(m1992c) <- data.frame(
  value = c(1, 2),
  label = c("forest", "human")  #ti viene al contrario human e foresta controlla
)
m2006c<-im.classify(m2006, seed=42, num_cluster=2)
levels(m2006c) <- data.frame(
  value = c(2, 1),
  label = c("forest", "human")
)
plot(m2006c)

#calcola frequenze
f1992<- freq(m1992c)
prop1992<- f1992$count / ncell(m1992c)
prop1992
perc1992<- prop1992*100
perc1992

f2006<- freq(m2006c)
prop2006<- f2006$count / ncell(m2006c)
prop2006
perc2006<- prop2006*100
perc2006

#tabella
data.frame(
  class=c("Forest", "Human"),
  perc1992=c(83,17),
  perc2006=c(45,55) 
)
