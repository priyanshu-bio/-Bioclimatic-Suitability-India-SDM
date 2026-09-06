# 🌿🪻🌿 Universal Species Distribution Modeling & Macro-Ecological Pipeline in R

An open-source, reproducible R framework for retrieving georeferenced species occurrences from the **Global Biodiversity Information Facility (GBIF)**, overlaying global **WorldClim** bioclimatic rasters, and extracting micro-climatic profiles for spatial ecological modeling.
## 🔔 aswagandha_india-map_visualization
![Uploading ashwagandha_distribution_map.png…]()

## 🟨 Features
- **Modular & Universal:** Easily adapted for any botanical or zoological species by updating a single variable string.
- **Automated Data Retrieval:** Fetches live occurrence records directly via the GBIF API.
- **Bioclimatic Integration:** Extracts 19 WorldClim environmental variables (BIO1–BIO19) at precise coordinates.
- **Publication-Ready Visualization:** Generates publication-quality spatial maps using `ggplot2` and `sf`.

## 🛠️ Requirements
Ensure you have the following R packages installed:
```R
install.packages(c("rgbif", "geodata", "terra", "sf", "dplyr", "ggplot2"))
