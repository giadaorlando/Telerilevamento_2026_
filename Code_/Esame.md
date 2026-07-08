###### Giada Orlando, Scienze e Gestione della Natura, corso di Telerilevamento geo-ecologico in R, 2026

# Monitoring Environmental Changes in the Florida Keys National Marine Sanctuary Using Multi-Sensor Remote Sensing

<img width="3325" height="1738" alt="water-13-03423-g001" src="https://github.com/user-attachments/assets/7d729490-abf7-492c-a317-48100c483144" />

> Boundary of the Marine Protected Area: Florida Keys National Marine Sanctuary. Image from: [Hurtado M, Burns RC, Andrew RG, Schwarzmann D, Moreira JC. User Satisfaction and Crowding at Florida Keys National Marine Sanctuary. Water. 2021; 13(23):3423.](https://doi.org/10.3390/w13233423)

---
 
## 1. Introduction
Marine Protected Areas (MPAs) play a fundamental role in the conservation of marine biodiversity and ecosystem services. Monitoring environmental changes within these protected areas is essential for evaluating long-term ecological conditions and supporting management strategies.

Satellite remote sensing provides continuous, large-scale observations of environmental variables that cannot be monitored efficiently using field surveys alone. The availability of freely accessible satellite products now allows the reconstruction of long-term environmental trends in coastal ecosystems.

This project aims to investigate the temporal evolution of selected satellite-derived environmental indicators within the Florida Keys National Marine Sanctuary (USA) using a reproducible workflow implemented in R.

## 2. Objectives of the project

The main objective of this project is to analyse temporal changes in environmental conditions within the Florida Keys National Marine Sanctuary using freely available satellite observations.
Particulary responding to the following research question: **How have key environmental indicators evolved in the Florida Keys National Marine Sanctuary between 2000 and 2024?**

Specific objectives are:

+ analyse the spatial distribution of **Sea Surface Temperature (SST)**;
+ analyse **Chlorophyll-a concentration**;
+ evaluate water transparency using the **Kd490 coefficient**;
+ compare environmental conditions across three representative years (**2000, 2012 and 2024**);
+ produce maps and descriptive statistics for each environmental indicator.

### 2.1 Study Area

The study focuses on the Florida Keys National Marine Sanctuary, one of the largest Marine Protected Areas in the United States.

The sanctuary protects coral reefs, seagrass meadows and mangrove ecosystems and has been extensively monitored through both in situ observations and satellite remote sensing.

Its long-term environmental datasets make it an ideal case study for testing reproducible remote sensing workflows.

### 2.2 Environmental Variables

Three environmental indicators were selected because they are consistently available throughout the study period and are commonly used in marine ecological monitoring.

INSERISCI TABELLINA

### 2.3 Temporal Comparison

To maintain methodological consistency, all variables will be analysed for the same observation years.

INSERISCI TABELLINA

Using identical temporal snapshots allows direct comparison among all environmental indicators.

### 2.4 Satellite Datasets










