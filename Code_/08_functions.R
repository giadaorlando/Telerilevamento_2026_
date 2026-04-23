# My functions!
somma <- function(x,y) {
  z=x+y
  return(z)
  }

difference <- function(x,y) {
  z=x-y
  return(z)
  }
difference(10,8)

install.packages("qrcode")
library(qrcode)
url<- "https://github.com/giadaorlando"
qr<- qr_code(url)
setwd("C:/Users/Giada/OneDrive/Documenti/doc UNIBO/immagini telerilevamento")
png("github_profile_qr.png", width = 1000, height = 1000)
plot(qr)
