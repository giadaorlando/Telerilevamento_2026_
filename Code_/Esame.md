###### Giada Orlando, Scienze e Gestione della Natura, corso di Telerilevamento geo-ecologico in R, 2026

# Analisi temporale di indicatori ambientali satellitari nel Florida Keys National Marine Sanctuary

<img width="3325" height="1738" alt="water-13-03423-g001" src="https://github.com/user-attachments/assets/7d729490-abf7-492c-a317-48100c483144" />

> Confine dell'Area MArina Protetta: Florida Keys National Marine Sanctuary. Immagine presa da: [Hurtado M, Burns RC, Andrew RG, Schwarzmann D, Moreira JC. User Satisfaction and Crowding at Florida Keys National Marine Sanctuary. Water. 2021; 13(23):3423.](https://doi.org/10.3390/w13233423)

---

## 1. Introduzione e area di studio 🗺️

Le Aree Marine Protette (AMP) svolgono un ruolo fondamentale nella conservazione della biodiversità marina e dei servizi ecosistemici. Il monitoraggio dei cambiamenti ambientali all'interno di queste aree protette è essenziale per valutare le condizioni ecologiche nel lungo periodo e supportare le strategie di gestione.
Il telerilevamento satellitare fornisce osservazioni continue e su larga scala delle variabili ambientali, che non possono essere monitorate in modo efficiente attraverso i soli rilievi sul campo. La disponibilità di prodotti satellitari ad accesso libero consente oggi di ricostruire le tendenze ambientali a lungo termine degli ecosistemi costieri.

Il **Florida Keys National Marine Sanctuary (FKNMS)** è un'area marina protetta situata nella Florida meridionale, negli Stati Uniti. Il santuario comprende ecosistemi di grande valore ecologico, tra cui barriere coralline, praterie di fanerogame marine e isole bordate da mangrovie. È amministrato dalla **National Oceanic and Atmospheric Administration (NOAA)** insieme allo Stato della Florida. Il FKNMS è stato istituito nel 1990 per proteggere le risorse naturali e culturali delle Florida Keys. Secondo la descrizione ufficiale della NOAA, il santuario tutela oltre 6.000 specie marine e include l'unica barriera corallina dell'America settentrionale continentale ([NOAA – The Sanctuary](https://floridakeys.noaa.gov/about/sanctuary.html)).

Il monitoraggio delle condizioni ambientali è particolarmente importante in questa regione, poiché gli ecosistemi costieri e corallini possono essere influenzati dall'aumento della temperatura marina, dalle variazioni della produttività fitoplanctonica e dalla riduzione della trasparenza dell'acqua. Quest'area è stata scelta in particolare per la grande disponibilità di dasaet ambientali risalenti a prima dell'inizio dell'effettiva attuazione delle pratiche di conservazione nell'area nel 1997 rendendo quest'area un caso di studio ideale per testare flussi di lavoro riproducibili basati sul telerilevamento satellitare.

<img width="3325" height="1738" alt="imageRGB" src="https://github.com/user-attachments/assets/7748c040-9714-45c6-af93-1f170869f8da" />

> Immagine satellitare del Florida Keys National Marine Sanctuary scaricata tramite Google Earth Engine.

---

## 2. Obiettivo del progetto in R 🎯

Questo progetto ha l'obiettivo di analizzare l'evoluzione temporale di alcuni indicatori ambientali derivati da dati satellitari all'interno del Florida Keys National Marine Sanctuary (USA), utilizzando un flusso di lavoro riproducibile implementato in R.

L'analisi confronta le condizioni osservate in tre anni rappresentativi:

- **2000**, anno iniziale;
- **2012**, anno intermedio;
- **2024**, anno finale.

Gli indicatori ambientali selezionati sono:

- **Sea Surface Temperature (SST)**, che descrive la temperatura superficiale del mare;
- **chlorophyll-a**, utilizzata come indicatore della biomassa fitoplanctonica superficiale;
- **Kd490**, coefficiente di attenuazione diffusa della luce a 490 nm, utilizzato come indicatore ottico della trasparenza dell'acqua.

L'obiettivo non è ricostruire un trend continuo per l'intero periodo 2000–2024, ma confrontare la distribuzione spaziale e i valori dei tre indicatori negli anni selezionati.

---

## 3. Il pacchetto MPAnalysisR 📦

Per rendere l'analisi semplice, riproducibile e applicabile anche ad altre aree marine protette è stato sviluppato il pacchetto R **[`MPAnalysisR`](https://github.com/giadaorlando/MPAnalysisR)**.

Il pacchetto contiene funzioni per:

- importare raster e confini vettoriali `load_raster()` `load_boundary()`; 
- uniformare i sistemi di riferimento `project_data()`;
- ritagliare e mascherare i raster sul confine di un'area marina protetta `crop_to_mpa()`;
- estrarre i valori degli indicatori `extract_indicator()`;
- calcolare statistiche descrittive `summary_statistics()`;
- confrontare anni differenti `compare_years()`;
- calcolare variazioni assolute e percentuali `calculate_change()`  `calculate_percent_change()`;
- produrre mappe, boxplot e mappe delle differenze `plot_indicator()` `plot_boxplot()` `plot_change()`.

Il workflow generale è:

```text
Importazione → Pre-processing spaziale → Statistiche → Confronto temporale → Visualizzazione
```

### 3.1. Installazione e caricamento

Il pacchetto può essere installato direttamente da GitHub tramite R:

```r
install.packages("remotes") # permette di installare pacchetti R da sorgenti diverse da CRAN
remotes::install_github("giadaorlando/MPAnalysisR")
```

Successivamente vengono caricati il pacchetto e le librerie necessarie:

```r
library(MPAnalysisR)
library(terra)
library(sf)
library(ggplot2)
library(patchwork)
```

---

## 4. Dati e metodologia 🛰️

### 4.1. Acquisizione dei dati

I raster annuali di **SST** e **chlorophyll-a** sono stati ottenuti da prodotti satellitari disponibili tramite **Google Earth Engine**. I dati di **Kd490** sono stati scaricati in formato NetCDF con dodici livelli mensili per ciascun anno. I livelli mensili sono stati mediati per ottenere un singolo raster annuale.

#### Sea Surface Temperature (SST)

La temperatura superficiale del mare è stata ottenuta dal prodotto **NOAA Optimum Interpolation Sea Surface Temperature (OISST), Version 2.1**, distribuito dal **NOAA Physical Sciences Laboratory**, accessibile tramite Google Earth Engine.

OISST combina osservazioni satellitari, principalmente provenienti dal sensore **AVHRR**, con misurazioni in situ raccolte da boe e navi.

- **Risoluzione spaziale:** 0,25° (circa 25 km);
- **risoluzione temporale originale:** giornaliera;
- **elaborazione utilizzata:** media annuale.

#### Chlorophyll-a

La concentrazione superficiale di chlorophyll-a è stata ottenuta dal prodotto **Copernicus Marine Satellite Ocean Color V6**, distribuito dal **Copernicus Marine Service** e scaricato tramite Google Earth Engine.

È un prodotto multi-sensore che combina osservazioni provenienti da **SeaWiFS, MERIS, MODIS Aqua, VIIRS e OLCI**.

- **Banda utilizzata:** `chlor_a`;
- **risoluzione spaziale:** 4 km;
- **risoluzione temporale originale:** giornaliera;
- **elaborazione utilizzata:** media annuale delle immagini giornaliere.

#### Kd490

Il coefficiente di attenuazione diffusa della luce a 490 nm (**Kd490**) è stato ottenuto da un prodotto ocean-colour multi-sensore distribuito dal **Copernicus Marine Service**.
Kd490 è espresso in **m⁻¹** e descrive la velocità con cui la luce viene attenuata nella colonna d’acqua. Valori maggiori indicano una maggiore attenuazione della luce e, generalmente, una minore trasparenza dell’acqua.

- **Variabile utilizzata:** `KD490`;
- **sensori:** la composizione varia in funzione dell’anno e comprende prodotti elaborati da MODIS, VIIRS e OLCI;
- **risoluzione spaziale:** 4 km;
- **risoluzione temporale scaricata:** mensile;
- **elaborazione utilizzata:** media annuale dei 12 raster mensili.

Per tutti gli indicatori sono stati analizzati gli anni **2000, 2012 e 2024**.

Il confine del santuario è stato importato da uno shapefile del Florida Keys National Marine Sanctuary.

### 4.2. Importazione dei dati

```r
boundary <- load_boundary("data/fknms_py.shp")

sst_2000 <- load_raster("data/SST_2000.tif")
sst_2012 <- load_raster("data/SST_2012.tif")
sst_2024 <- load_raster("data/SST_2024.tif")

chl_2000 <- load_raster("data/CHL_2000.tif")
chl_2012 <- load_raster("data/CHL_2012.tif")
chl_2024 <- load_raster("data/CHL_2024.tif")

kd490_2000_monthly <- load_raster("data/KD490_2000.nc")
kd490_2012_monthly <- load_raster("data/KD490_2012.nc")
kd490_2024_monthly <- load_raster("data/KD490_2024.nc")
```


### 4.3. Calcolo delle medie annuali di Kd490

Ogni file NetCDF contiene i dodici mesi dell'anno. La media annuale è stata calcolata ignorando i valori mancanti:

```r
kd490_2000 <- mean(kd490_2000_monthly, na.rm = TRUE)
kd490_2012 <- mean(kd490_2012_monthly, na.rm = TRUE)
kd490_2024 <- mean(kd490_2024_monthly, na.rm = TRUE)

```

### 4.4. Uniformazione del sistema di riferimento

Il confine del santuario è stato trasformato nello stesso sistema di coordinate dei raster:

```r
boundary <- project_data(
  boundary,
  terra::crs(sst_2000)
)
```

Prima di procedere è stato verificato che tutti i raster utilizzassero lo stesso sistema di riferimento.

### 4.5. Ritaglio sull'area marina protetta

La funzione `crop_to_mpa()` esegue insieme le operazioni di `crop()` e `mask()`, mantenendo soltanto le celle comprese nel confine del FKNMS:

```r
sst_2000_crop <- crop_to_mpa(sst_2000, boundary)
sst_2012_crop <- crop_to_mpa(sst_2012, boundary)
sst_2024_crop <- crop_to_mpa(sst_2024, boundary)

chl_2000_crop <- crop_to_mpa(chl_2000, boundary)
chl_2012_crop <- crop_to_mpa(chl_2012, boundary)
chl_2024_crop <- crop_to_mpa(chl_2024, boundary)

kd490_2000_crop <- crop_to_mpa(kd490_2000, boundary)
kd490_2012_crop <- crop_to_mpa(kd490_2012, boundary)
kd490_2024_crop <- crop_to_mpa(kd490_2024, boundary)
```

---

## 5. Distribuzione spaziale degli indicatori 🗺️

Per rendere confrontabili le mappe dello stesso indicatore è stata utilizzata una scala cromatica comune ai tre anni. Tutte le mappe impiegano una palette **viridis** e riportano il confine del santuario.

### 5.1. Sea Surface Temperature

```r
sst_limits <- range(
  terra::minmax(sst_2000_crop),
  terra::minmax(sst_2012_crop),
  terra::minmax(sst_2024_crop),
  na.rm = TRUE 
) # serve affinché tutte le mappe usino la stessa scala di colori

p_sst_2000 <- plot_indicator(
  sst_2000_crop, boundary,
  title = "2000",
  legend_title = "SST (°C)",
  limits = sst_limits 
)

p_sst_2012 <- plot_indicator(
  sst_2012_crop, boundary,
  title = "2012",
  legend_title = "SST (°C)",
  limits = sst_limits
)

p_sst_2024 <- plot_indicator(
  sst_2024_crop, boundary,
  title = "2024",
  legend_title = "SST (°C)",
  limits = sst_limits
)

p_sst_all <- wrap_plots(
  p_sst_2000,
  p_sst_2012,
  p_sst_2024,
  ncol = 3,
  guides = "collect" # unisce le legende
) +
  plot_annotation(
    title = "Spatial distribution of SST"
  ) & # applica il tema a tutti i grafici della composizione
  theme(
    legend.position = "right",
    plot.title = element_text(
      hjust = 0.5, # centra il titolo
      face = "bold" # lo fa in grassetto
    )
  )

p_sst_all
```

<img width="1280" height="709" alt="p_sst_all" src="https://github.com/user-attachments/assets/5c528e65-71d6-446f-a9b1-f44eb0ab7ddb" />

> Distribuzione spaziale della SST nel 2000, 2012 e 2024. La stessa scala cromatica è utilizzata per tutti gli anni.

### 5.2. Chlorophyll-a

La stessa procedura è stata applicata alla chlorophyll-a:

<details>
<summary><b>Mostra il codice R</b></summary>

```r
chl_limits <- range(
  terra::minmax(chl_2000_crop),
  terra::minmax(chl_2012_crop),
  terra::minmax(chl_2024_crop),
  na.rm = TRUE
)

p_chl_2000 <- plot_indicator(
  chl_2000_crop, boundary,
  title = "2000",
  legend_title = "Chlorophyll-a (mg/m³)",
  limits = chl_limits
)

p_chl_2012 <- plot_indicator(
  chl_2012_crop,
  boundary,
  title = "2012",
  legend_title = "Chlorophyll-a (mg/m³)",
  limits = chl_limits
)

p_chl_2024 <- plot_indicator(
  chl_2024_crop,
  boundary,
  title = "2024",
  legend_title = "Chlorophyll-a (mg/m³)",
  limits = chl_limits
)

p_chl_all <- wrap_plots(
  p_chl_2000,
  p_chl_2012,
  p_chl_2024,
  ncol = 3,
  guides = "collect"
)+
  plot_annotation(
    title = "Spatial distribution of Chlorophyll-a"
  ) &
  theme(
    legend.position = "right",
    plot.title = element_text(
      hjust = 0.5,
      face = "bold"
    )
  )
p_chl_all

```
</details>

<img width="1280" height="709" alt="p_chl_all" src="https://github.com/user-attachments/assets/18f18f76-7c18-4d6e-9f32-ce0f989a480b" />

> Distribuzione spaziale della chlorophyll-a nel 2000, 2012 e 2024.

### 5.3. Kd490

<details>
<summary><b>Mostra il codice R</b></summary>
  
```r
kd490_limits <- range(
  terra::minmax(kd490_2000_crop),
  terra::minmax(kd490_2012_crop),
  terra::minmax(kd490_2024_crop),
  na.rm = TRUE
)

p_kd490_2000 <- plot_indicator(
  kd490_2000_crop, boundary,
  title = "2000",
  legend_title = "Kd490 (m⁻¹)",
  limits = kd490_limits
)

p_kd490_2024 <- plot_indicator(
  kd490_2024_crop,
  boundary,
  title = "2024",
  legend_title = "Kd490 (m⁻¹)",
  limits = kd490_limits
)

p_kd490_all <- wrap_plots(
  p_kd490_2000,
  p_kd490_2012,
  p_kd490_2024,
  ncol = 3,
  guides = "collect"
)+
  plot_annotation(
    title = "Spatial distribution of kd490"
  ) &
  theme(
    legend.position = "right",
    plot.title = element_text(
      hjust = 0.5,
      face = "bold"
    )
  )
p_kd490_all

```
</details>

<img width="1280" height="709" alt="p_kd490_all" src="https://github.com/user-attachments/assets/38ea7b47-8a90-4607-b05f-76ef8d739780" />


> Distribuzione spaziale del coefficiente Kd490 nel 2000, 2012 e 2024. Valori maggiori indicano una più forte attenuazione della luce nella colonna d'acqua.

---

## 6. Statistiche descrittive 📊

Per ciascun raster sono state calcolate numerosità delle celle valide, media, mediana, deviazione standard, minimo e massimo e sono stati uniti poi in una singola tabella riassuntiva:

```r
make_stats <- function(raster, year, variable) {
  result <- summary_statistics(raster)
  result$Year <- year # aggiunta della colonna Year
  result$Variable <- variable # aggiunta colonna Variabile

  result[, c( # restituisce il data frame con queste colonne e in questo ordine
    "Variable", "Year", "N",
    "Mean", "Median", "SD",
    "Minimum", "Maximum"
  )]
} 
```

<details>
<summary><b>Mostra il codice R</b></summary>
  
```r
sst_stats <- rbind(
  make_stats(sst_2000_crop, 2000, "SST"),
  make_stats(sst_2012_crop, 2012, "SST"),
  make_stats(sst_2024_crop, 2024, "SST")
)

sst_stats

chl_stats <- rbind(
  make_stats(chl_2000_crop, 2000, "Chlorophyll-a"),
  make_stats(chl_2012_crop, 2012, "Chlorophyll-a"),
  make_stats(chl_2024_crop, 2024, "Chlorophyll-a")
)

chl_stats

kd490_stats <- rbind(
  make_stats(kd490_2000_crop, 2000, "Kd490"),
  make_stats(kd490_2012_crop, 2012, "Kd490"),
  make_stats(kd490_2024_crop, 2024, "Kd490")
)

kd490_stats

all_stats <- rbind(
  sst_stats,
  chl_stats,
  kd490_stats
)

all_stats
```
</details>

### 6.1. Risultati

| Indicatore | Anno | N | Media | Mediana | SD | Minimo | Massimo |
|---|---:|---:|---:|---:|---:|---:|---:|
| SST (°C) | 2000 | 35 | 26.606 | 26.645 | 0.249 | 26.081 | 26.968 |
| SST (°C) | 2012 | 35 | 26.514 | 26.513 | 0.382 | 25.784 | 27.131 |
| SST (°C) | 2024 | 35 | 27.138 | 27.113 | 0.335 | 26.481 | 27.741 |
| Chlorophyll-a (mg/m³) | 2000 | 748 | 1.352 | 0.767 | 1.537 | 0.136 | 9.289 |
| Chlorophyll-a (mg/m³) | 2012 | 840 | 1.655 | 0.897 | 1.755 | 0.117 | 13.658 |
| Chlorophyll-a (mg/m³) | 2024 | 819 | 1.656 | 0.871 | 1.927 | 0.114 | 9.214 |
| Kd490 (m⁻¹) | 2000 | 645 | 0.0724 | 0.0595 | 0.0355 | 0.0347 | 0.2402 |
| Kd490 (m⁻¹) | 2012 | 645 | 0.0734 | 0.0569 | 0.0399 | 0.0333 | 0.2516 |
| Kd490 (m⁻¹) | 2024 | 645 | 0.0811 | 0.0563 | 0.0534 | 0.0343 | 0.2937 |


> [!IMPORTANT]
> Il numero di celle è diverso tra gli indicatori perché i prodotti satellitari hanno risoluzioni differenti. Per la chlorophyll-a cambia anche tra gli anni a causa della diversa disponibilità di celle valide.

---

## 7. Confronto delle distribuzioni

La funzione `compare_years()` estrae i valori dai tre raster e li riunisce in un unico data frame. La funzione `plot_boxplot()` permette quindi di confrontarne la distribuzione:

```r
sst_comparison <- compare_years( 
  rasters = list(sst_2000_crop, sst_2012_crop, sst_2024_crop),
  years = c(2000, 2012, 2024),
  variable = "SST"
) # non calcola semplicemente una media per anno, ma conserva la distribuzione completa dei valori, necessaria per costruire il boxplot.

p_sst_boxplot <- plot_boxplot(
  sst_comparison,
  title = "SST distribution in 2000, 2012 and 2024",
  y_label = "SST (°C)"
)
```

La procedura è stata ripetuta per chlorophyll-a e Kd490.

<p align="center">
<img width="566" height="350" alt="p_sst_boxplot" src="https://github.com/user-attachments/assets/14b4b6e5-889f-4568-ab2a-b22f2aba55c0" />
<p align="center">
<img width="566" height="350" alt="p_chl_boxplot" src="https://github.com/user-attachments/assets/22d0924f-fb06-479f-9d57-243b1574afa8" />
<p align="center">
<img width="566" height="350" alt="p_kd490_boxplot" src="https://github.com/user-attachments/assets/7068274b-5259-4d52-a62a-2a25e28280ae" />

> Confronto della distribuzione di SST, chlorophyll-a e Kd490 nei tre anni selezionati.

I boxplot devono essere interpretati come una descrizione della distribuzione spaziale delle celle raster. Le celle vicine non costituiscono repliche statisticamente indipendenti, perché i dati spaziali possono essere autocorrelati.

---

## 8. Variazioni spaziali tra 2000 e 2024 🔄

Prima di calcolare le differenze è stata verificata la corrispondenza di estensione, risoluzione e sistema di riferimento:

```r
compareGeom(sst_2000_crop, sst_2024_crop)
compareGeom(chl_2000_crop, chl_2024_crop)
compareGeom(kd490_2000_crop, kd490_2024_crop)
```

La variazione è stata calcolata cella per cella come:

$$
\Delta X = X_{2024} - X_{2000}
$$

```r
sst_change <- calculate_change(
  old_raster = sst_2000_crop,
  new_raster = sst_2024_crop
)

p_sst_change <- plot_change(
  change_raster = sst_change,
  boundary = boundary,
  title = "SST change: 2024–2000",
  legend_title = "ΔSST (°C)"
)
```

Lo stesso procedimento è stato applicato a chlorophyll-a e Kd490.

<p align="center">
<img width="566" height="350" alt="p_sst_change" src="https://github.com/user-attachments/assets/6ba07a96-a29c-42c0-87ae-a33c6700599a" />
<p align="center">
<img width="566" height="350" alt="p_kd490_change" src="https://github.com/user-attachments/assets/3aa75cb8-f8b2-4b85-b705-ef9ed821d2a1" />
<p align="center">
<img width="566" height="350" alt="p_chl_change" src="https://github.com/user-attachments/assets/6585a755-8a3f-4195-bded-bfc12cabe1bc" />

> Variazione spaziale di SST, chlorophyll-a e Kd490 tra il 2000 e il 2024. Valori positivi indicano un aumento, mentre valori negativi indicano una diminuzione.

---

## 9. Variazione delle medie

La variazione percentuale è stata calcolata come:

$$
\text{Variazione percentuale} =
\frac{\text{Media}_{2024} - \text{Media}_{2000}}
{\text{Media}_{2000}} \times 100
$$

| Indicatore | Media 2000 | Media 2012 | Media 2024 | Differenza 2024–2000 | Variazione 2000–2024 |
|---|---:|---:|---:|---:|---:|
| SST | 26.606 °C | 26.514 °C | 27.138 °C | **+0.532 °C** | +2.00% |
| Chlorophyll-a | 1.352 mg/m³ | 1.655 mg/m³ | 1.656 mg/m³ | **+0.304 mg/m³** | +22.46% |
| Kd490 | 0.0724 m⁻¹ | 0.0734 m⁻¹ | 0.0811 m⁻¹ | **+0.0088 m⁻¹** | +12.09% |

> [!NOTE]
> Per la SST è preferibile discutere soprattutto la differenza assoluta di **+0.53 °C**. Una variazione percentuale calcolata sulla scala Celsius ha un significato fisico limitato.

### 9.1. Andamento delle medie nei tre anni

```r
p_mean_sst <- ggplot(
  sst_stats,
  aes(x = factor(Year), y = Mean, group = 1)
) +
  geom_line() +
  geom_point(size = 3) +
  labs(
    title = "Mean SST through time",
    x = "Year",
    y = "Mean SST (°C)"
  ) +
  theme_minimal()
```

La stessa procedura è stata applicata a chlorophyll-a e Kd490.

<p align="center">
<img width="566" height="350" alt="sst_percent_change" src="https://github.com/user-attachments/assets/c8a428b0-48d3-4572-a1f2-d6b903f14444" />
<p align="center">
<img width="566" height="350" alt="chl_percent_change" src="https://github.com/user-attachments/assets/dc9c3b1b-c52f-4c4b-813d-3344d1957dd9" />
<p align="center">
<img width="566" height="350" alt="kd490_percent_change" src="https://github.com/user-attachments/assets/f17a3163-f7be-426b-819f-03816eec52d2" />

> Medie di SST, chlorophyll-a e Kd490 negli anni 2000, 2012 e 2024.

---

## 10. Discussione dei risultati 🔎

### 10.1. Sea Surface Temperature

La SST media rimane relativamente stabile tra il 2000 e il 2012, passando da 26.61 °C a 26.51 °C. Nel 2024 raggiunge invece 27.14 °C, con un aumento di circa **0.53 °C** rispetto al 2000. Anche minimo, mediana e massimo sono più elevati nel 2024, indicando condizioni generalmente più calde nell'area del santuario.

### 10.2. Chlorophyll-a

La chlorophyll-a media aumenta del **22.46%** tra il 2000 e il 2024. Tuttavia, gran parte della variazione è già presente nel 2012 e le medie del 2012 e del 2024 sono quasi identiche.

In tutti gli anni la media è nettamente superiore alla mediana. Questa differenza, insieme all'elevata deviazione standard, indica una distribuzione asimmetrica caratterizzata da alcune celle con concentrazioni elevate. L'aumento non deve quindi essere interpretato come uniforme in tutto il santuario.

### 10.3. Kd490

Il Kd490 medio aumenta del **12.09%** tra il 2000 e il 2024. Un Kd490 maggiore corrisponde a una più forte attenuazione della luce e può indicare una minore trasparenza della colonna d'acqua.

La mediana diminuisce però leggermente, mentre aumentano massimo e deviazione standard. L'incremento della media sembra quindi essere determinato soprattutto da aree localizzate con valori elevati. Le mappe delle differenze sono necessarie per individuare queste zone.

### 10.4. Interpretazione complessiva

Il confronto evidenzia nel 2024:

- condizioni superficiali più calde;
- valori medi di chlorophyll-a superiori a quelli del 2000, ma simili al 2012;
- un Kd490 medio maggiore e una più elevata eterogeneità spaziale.

Chlorophyll-a e Kd490 mostrano entrambi un aumento della media rispetto al 2000. Questa corrispondenza può indicare una co-variazione tra produttività fitoplanctonica e proprietà ottiche dell'acqua, ma l'analisi descrittiva non permette di dimostrare un rapporto causale.

---

## 11. Limiti dell'analisi ⚠️

- Sono stati confrontati solamente tre anni; i risultati descrivono **differenze tra anni selezionati**, non un trend continuo dal 2000 al 2024.
- Le celle raster sono spazialmente autocorrelate e non rappresentano osservazioni statisticamente indipendenti.
- I tre indicatori hanno risoluzioni spaziali differenti.
- Il numero di celle valide della chlorophyll-a cambia tra gli anni.
- Le differenze possono essere influenzate da copertura nuvolosa, disponibilità dei dati, algoritmi satellitari e caratteristiche dei sensori.
- L'analisi permette di descrivere pattern temporali e spaziali, ma non di attribuirli direttamente a una causa specifica.

---

## 12. Conclusioni 🌊

Il progetto ha sviluppato un workflow riproducibile in R per analizzare l'evoluzione temporale di indicatori ambientali satellitari in questo caso all'interno del Florida Keys National Marine Sanctuary che è stato scelto come caso studio.

Il confronto tra 2000, 2012 e 2024 ha mostrato un aumento della SST nel 2024 e un incremento delle medie di chlorophyll-a e Kd490 rispetto al 2000. Per questi ultimi due indicatori, la divergenza tra media e mediana evidenzia che i cambiamenti sono probabilmente eterogenei e concentrati in alcune aree.

Il pacchetto `MPAnalysisR` integra importazione, elaborazione spaziale, calcolo delle statistiche e visualizzazione in un unico workflow. Pur essendo stato sviluppato sul caso di studio delle Florida Keys, può essere riutilizzato per altre aree marine protette e altri indicatori raster compatibili.

Per approfondire i risultati sarebbe utile analizzare serie temporali annuali complete, armonizzare la risoluzione dei prodotti e valutare quantitativamente le relazioni spaziali tra SST, chlorophyll-a e Kd490.

---








