###### Giada Orlando, Scienze e Gestione della Natura, corso di Telerilevamento geo-ecologico in R, 2026

# MPAnalysisR: an R package for multi-sensor satellite analysis of Marine Protected Areas

<img width="3325" height="1738" alt="water-13-03423-g001" src="https://github.com/user-attachments/assets/7d729490-abf7-492c-a317-48100c483144" />

> Delimitazione Area Marina Protetta: Florida Keys National Marine Sanctuary. Immagine presa da: [Hurtado M, Burns RC, Andrew RG, Schwarzmann D, Moreira JC. User Satisfaction and Crowding at Florida Keys National Marine Sanctuary. Water. 2021; 13(23):3423.](https://doi.org/10.3390/w13233423)

---

## 1. Introduzione
**MPAnalysisR** è un pacchetto open-source per R progettato per facilitare l'analisi degli indicatori ambientali derivati da satellite per le Aree Marine Protette (AMP).

Il pacchetto fornisce un flusso di lavoro (workflow) riproducibile per scaricare, pre-elaborare, analizzare e confrontare dataset oceanografici multi-temporali provenienti da diverse piattaforme satellitari.

Sebbene sia stato sviluppato utilizzando il Florida Keys National Marine Sanctuary come caso di studio, il pacchetto è progettato per essere completamente riutilizzabile per qualsiasi Area Marina Protetta a livello mondiale.

## 2. Obiettivo del progetto

I principali obiettivi del progetto sono:

-Sviluppare un pacchetto R per il monitoraggio basato su dati satellitari delle Aree Marine Protette.
-Fornire un flusso di lavoro (workflow) standardizzato per l'elaborazione dei dati oceanografici di telerilevamento.
-Confrontare le condizioni ambientali tra diversi periodi di osservazione.
-Produrre mappe e output grafici.
-Creare una struttura (framework) modulare facilmente adattabile ad altri casi di studio
