# R code for visualizing multisprectral data

install.packages("viridis")

library(viridis)

library(terra) #pacchetto for using spatial data
library(imageRy) #pacchetto per immagni satellitari

im.list()
# Sentinel 2-bands
# https://gisgeography.com/sentinel-2-bands-combinations/
im.import("sentinel.dolomites.b2.tif")
b2 <- im.import("sentinel.dolomites.b2.tif")

# changing colors
cl <-colorRampPalette(c("darkorchid2","cyan3","darkgoldenrod2"))(100)
plot(b2,col=cl)

# minor numero di sfumature
cl <-colorRampPalette(c("darkorchid2","darkolivegreen3","darkgoldenrod2"))(3)
plot(b2,col=cl)

#usare viridis per cambiare colori
plot(b2, col=inferno(100))

#esercizio
cl <-colorRampPalette(c("gray24","gray48","gray93"))(100)
plot(b2,col=cl)

#par  per mettere due immagin nella stessa riga
par(mfrow=c(1,2))
plot(b2, col=inferno(100))
plot(b2,col=cl)
dev.off() #per chiudere qualsiasi finestra grafica

im.multiframe(1,2) #funzione che fa la stessa cosa ma più semplice
plot(b2, col=inferno(100))
plot(b2,col=cl)

#band 3
b3 <- im.import("sentinel.dolomites.b3.tif")
library(viridis)
plot(b3,col=plasma(100))

#band 4
b4 <- im.import("sentinel.dolomites.b4.tif")
plot(b4,col=plasma(100))

# banda 8
b8 <- im.import("sentinel.dolomites.b8.tif")

#esercizio: multiframe con le 4 bande, legends: in lane with the wavelenght
cl <-colorRampPalette(c("gray24","gray48","gray93"))(100)
clb <-colorRampPalette(c("dark blue","blue","light blue"))(100)
clg <-colorRampPalette(c("dark green","green","light green"))(100)
clr <-colorRampPalette(c("brown4","brown1","indianred1"))(100)

im.multiframe(2,2)
plot(b2, col=cl)
plot(b3,col=clb)
plot(b4,col=clg)
plot(b8,col=clr)

sentinel <- c(b2, b3, b4, b8)
plot(sentinel)
plot(sentinel, col=plasma(100))
plot(sentinel$sentinel.dolomites.b8)   # il dollaro serve per collegare vari pezzi insieme in R

#layer1=b2, layer2=b3, layer3=b4, layer4=b8
> layer
class       : SpatRaster 
size        : 934, 1059, 4  (nrow, ncol, nlyr)
resolution  : 10, 10  (x, y)
extent      : 740350, 750940, 5158820, 5168160  (xmin, xmax, ymin, ymax)
coord. ref. : WGS 84 / UTM zone 32N (EPSG:32632) 
sources     : sentinel.dolomites.b2.tif  
              sentinel.dolomites.b3.tif  
              sentinel.dolomites.b4.tif  
              sentinel.dolomites.b8.tif  
names       : sentine~ites.b2, sentine~ites.b3, sentine~ites.b4, sentine~ites.b8 
min values  :            1338,            1293,             750,            1159 
max values  :            6903,            6780,            7229,            7313 

plot(sentinel[[4]])

# stack 
