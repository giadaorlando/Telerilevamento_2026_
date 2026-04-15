# Ice spread: titolo della presentazione

<img width="224" height="225" alt="download" src="https://github.com/user-attachments/assets/bf4d5584-335d-418b-84b0-26bbb9a96e08" />

In questa riga scrivo l'intro alle mie analisi

## immagine scaricata 

L'immagine è stata scaricata da 

Pacchetti usati in R:

``` r
library(terra) #....
library(imageRy) #package for RS didactis

```

Importazione dei dati tramite `setwd()`:
``` r
setwd("....")
getwd()
list.files()
```
Dati importati via `rast()`:
``` r
ice <-rast("ISS074-E-417243_lrg.jpg")
```

## Plottaggio delle singole bande

Le singole bande sono state plottate usando un multiframe

``` r
im.multiframe(1,2)
plot(ice[[1]])
plot(ice[[2]])
```

Questo l'output del plottaggio:

....

> Nota: l'immagine è già stata analizzata da Earth Observatory

Se vogliamo inserire un elenco puntato basta usare il +:
+ bla
+ bla
+ bla

Istogrammi per la mia immagine 
``` r
im.multiframe(1,2)

```
Output:

immagine

