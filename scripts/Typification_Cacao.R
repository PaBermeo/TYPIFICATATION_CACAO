### Typification cacao code#### 

pacman::p_load(dplyr, cartography, cowplot, geobr, ggplot2, ggpattern, ggspatial, gridGraphics, sf, sp, tmap, terra, raster, readr, rnaturalearth, viridis)

#Load DEM
DEM <- raster("Mapa fincas/elev.tif")

#Load shapefile
COL <- st_read("Mapa fincas/Servicios_Públicos_-_Municipios_2005.shp")
SANT <- COL[COL$DEPTO == "SANTANDER", ]
plot(SANT)

#Load farms location
Farms <- read_delim("Mapa fincas/Occs_fincas.csv", delim = ';', col_names = T) |> as.data.frame()
wgs <- "+proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0"
WGS84 <- sp::CRS(wgs)
occ <- sp::SpatialPointsDataFrame(Farms[, c('LONGITUDE', 'LATITUDE')], Farms, proj4string = WGS84)

#

tm_shape(DEM, bbox= c(-8296522, -8296522, -8068109, 909767.8)) +
  tm_raster(style = "cont", legend.reverse= T, #legend.format = list(text.align = 'right'),
            palette = palette, title = 'Elevation (m)') +

  
tm_shape(DEM, bbox= c(-83,-80.4, 63,8.2)) +
  tm_raster(style = "cont", legend.reverse= T, #legend.format = list(text.align = 'right'),
            palette = palette, title = 'Elevation (m)')tm_shape(DEM, bbox= c(-83, 63, -80.4, 8.2)) +
  tm_shape(SANT) +
  tm_borders(col = 'gray50', lwd = 0.5) +
  tm_shape(occ) +
  tm_symbols(size= 0.2, col= 'red', alpha= 0.8) +
  tm_compass(position = c(0.9, 0.7), size= 3.2) +
  tm_scale_bar(text.size = 0.6, position = c(0.4, 0), width = 0.2) + #scale bar
  tm_graticules(lines = FALSE, labels.rot = c(0, 90), labels.size = 0.8)
  tm_add_legend(type = "symbol",
              labels = "Cacao Farms",
              col = "red",
              lwd = 3,
              size = 0.5
  ) +
  tm_add_legend(type = "line",
                labels = "Administrative border",
                col = "gray50",
                lwd = 3
  )

