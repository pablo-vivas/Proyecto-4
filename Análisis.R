##Análisis

#Librerías
library(readxl)
library(sp)
library(sf)
library(tidyverse)
library(rgdal)
library(RColorBrewer)
library(spdep)
library(tmap)

indicadores <- read_excel("Datos/Datos Cantonales.xlsx")
cantones_sp <- read_sf(dsn="Datos",layer = "Cantones")

#Merge
datos <- merge(cantones_sp,indicadores)
datos <- datos[,-c(1:4)]
rm(cantones_sp,indicadores)

#Quitar la Isla del Coco
new_bb = c(286803.0, 889158.2, 658864.2,1241118.1)
names(new_bb) = c("xmin", "ymin", "xmax", "ymax")
attr(new_bb, "class") = "bbox"

attr(st_geometry(datos), "bbox") <- new_bb

rm(new_bb)

shapefile(sub, 'datos/procesados/cantones.shp', overwrite = TRUE)

#Primer ploteo
#Estadísticas descriptivas
tm_shape(datos) +
  tm_polygons("dengue",n=9, palette="-RdYlBu")

tm_shape(datos) +
  tm_polygons("tugurio", palette="-RdYlBu")

tm_shape(datos) +
  tm_polygons("densidad", palette="-RdYlBu")

tm_shape(datos) +
  tm_polygons("residuos", palette="-RdYlBu")

tm_shape(datos) +
  tm_polygons("acueducto", palette="-RdYlBu")
