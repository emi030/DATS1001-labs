library(leaflet)
leaflet() %>% 
  addTiles() %>%   # Add default OpenStreetMap map tiles
  addMarkers(lat = 38.89789351878153, lng = -77.03499808558989, 
             label = "Monroe Hall")
    
             