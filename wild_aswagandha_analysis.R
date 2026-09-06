install.packages(c("rgbif", "geodata", "terra", "sf", "ggplot2", "dplyr"))
# This code is universal for all plant present in GBIF dataset and visualization according to the coordination of india  
species_name <- "Withania somnifera"


gbif_data <- occ_data(
  scientificName = species_name,
  hasCoordinate = TRUE,
  limit = 2000
)


occurrences <- gbif_data$data %>%
  select(decimalLongitude, decimalLatitude, countryCode) %>%
  filter(!is.na(decimalLongitude) & !is.na(decimalLatitude)) %>%
  filter(countryCode == "IN") # Filter specifically for India


write.csv(occurrences, "plant_occurrences.csv", row.names = FALSE)
print(paste("Total valid records found in India:", nrow(occurrences)))

options(timeout = 900)


bioclim_data <- worldclim_global(var = "bio", res = 2.5, path = tempdir())


india_extent <- ext(68, 98, 6, 38) 
india_bioclim <- crop(bioclim_data, india_extent)




plant_points <- vect(occurrences, geom = c("decimalLongitude", "decimalLatitude"), crs = "EPSG:4326")


extracted_climate <- extract(india_bioclim, plant_points)


final_dataset <- cbind(occurrences, extracted_climate)


head(final_dataset)







plant_df <- as.data.frame(plant_points, geom = "XY")


ggplot() +
  geom_point(data = plant_df, aes(x = x, y = y), color = "darkgreen", alpha = 0.6, size = 2) +
  labs(
    title = paste("Geographical Occurrence & Suitable Habitat Envelope of", species_name),
    subtitle = "Data source: GBIF & WorldClim Bioclimatic Dataset",
    x = "Longitude (°E)",
    y = "Latitude (°N)"
  ) +
  theme_minimal()









library(rnaturalearth)
library(ggplot2)

india_map <- ne_countries(scale = "medium", country = "India", returnclass = "sf")


p <- ggplot() +
 
  geom_sf(data = india_map, fill = "gray95", color = "gray60") +
  
  geom_point(data = plant_df, aes(x = x, y = y), 
             color = "darkgreen", alpha = 0.7, size = 2) +
 
  coord_sf(xlim = c(68, 98), ylim = c(8, 38), expand = FALSE) +
  labs(
    title = expression(italic("Withania somnifera") ~ "Spatial Occurrence Distribution in India"),
    subtitle = "Data source: GBIF Georeferenced Records & WorldClim Dataset",
    x = "Longitude (°E)",
    y = "Latitude (°N)"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(face = "bold", size = 13),
    panel.grid.major = element_line(color = "gray90")
  )


print(p)


ggsave("ashwagandha_distribution_map.png", plot = p, width = 8, height = 10, dpi = 300)


write.csv(occurrences, file = "gbif_ashwagandha_occurrences.csv", row.names = FALSE)


write.csv(final_dataset, file = "ashwagandha_final_dataset.csv", row.names = FALSE)

shell.exec(getwd())




