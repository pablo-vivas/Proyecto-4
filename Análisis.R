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
library(tmaptools)
library(spatialreg)
library(epitools)
library(DCluster)
library(plotrix)

indicadores <- read_excel("Datos/Datos Cantonales.xlsx")
cantones_sp <- read_sf(dsn="Datos",layer = "Cantones")

#Merge
datos_sf <- merge(cantones_sp,indicadores)
datos_sf <- datos_sf[,-c(1:4)]
rm(cantones_sp,indicadores)

#Quitar la Isla del Coco
new_bb = c(286803.0, 889158.2, 658864.2,1241118.1)
names(new_bb) = c("xmin", "ymin", "xmax", "ymax")
attr(new_bb, "class") = "bbox"

attr(st_geometry(datos_sf), "bbox") <- new_bb

rm(new_bb)

#Primer ploteo
#Estadísticas descriptivas
tm_shape(datos_sf) +
  tm_polygons("casos",n=9, palette="-RdYlBu")

tm_shape(datos_sf) +
  tm_polygons("dengue",n=9, palette="-RdYlBu")

tm_shape(datos_sf) +
  tm_polygons("tugurio", palette="-RdYlBu")

tm_shape(datos_sf) +
  tm_polygons("densidad", palette="-RdYlBu")

tm_shape(datos_sf) +
  tm_polygons("residuos", palette="-RdYlBu")

tm_shape(datos_sf) +
  tm_polygons("acueducto", palette="-RdYlBu")

datos_sp <- as(datos_sf,"Spatial")
datos_sp@bbox <- matrix(c(286803.0, 889158.2, 658864.2,1241118.1),ncol = 2,byrow = F)

rm(datos_sf)

#Análisis Vecinos
coords <- coordinates(datos_sp)
id <-row.names(datos_sp) 

nb.1 <- poly2nb(datos_sp,queen = T)
nb.2 <- poly2nb(datos_sp,queen = F)
nb.3 <- knn2nb(knearneigh(coords, k=2), row.names=id)
nb.4 <- knn2nb(knearneigh(coords, k=4), row.names=id)


plot(datos_sp, axes=TRUE, border="gray")
plot(nb.1,coords, pch = 20, cex = 0.6, add = T, col = "red")

plot(datos_sp, axes=TRUE, border="gray")
plot(nb.4,coords, pch = 20, cex = 0.6, add = T, col = "red")

#Matrices de pesos
w.11 <- nb2listw(nb.1,style = "W")
w.12 <- nb2listw(nb.1,style = "B")
w.13 <- nb2listw(nb.1,style = "S")

w.21 <- nb2listw(nb.2,style = "W")
w.22 <- nb2listw(nb.2,style = "B")
w.23 <- nb2listw(nb.2,style = "S")

w.31 <- nb2listw(nb.3,style = "W")
w.32 <- nb2listw(nb.3,style = "B")
w.33 <- nb2listw(nb.3,style = "S")

w.41 <- nb2listw(nb.4,style = "W")
w.42 <- nb2listw(nb.4,style = "B")
w.43 <- nb2listw(nb.4,style = "S")

#Test de Moran
moran.test(datos_sp$dengue,listw=w.11)
moran.test(datos_sp$dengue,listw=w.12)
moran.test(datos_sp$dengue,listw=w.13)
moran.test(datos_sp$dengue,listw=w.21)
moran.test(datos_sp$dengue,listw=w.22)
moran.test(datos_sp$dengue,listw=w.23)
moran.test(datos_sp$dengue,listw=w.31)
moran.test(datos_sp$dengue,listw=w.32)
moran.test(datos_sp$dengue,listw=w.33)
moran.test(datos_sp$dengue,listw=w.41)
moran.test(datos_sp$dengue,listw=w.42)
moran.test(datos_sp$dengue,listw=w.43)

#Se elije Reina y matriz W
rm(nb.2,nb.3,nb.4,w.12,w.13,w.21,w.22,w.23,w.31,w.32,w.33,w.41,w.42,w.43,coords,id)

#Casos de influencia

msp <- moran.plot(datos_sp$dengue, listw=w.11, quiet=TRUE,xlab="Casos de Dengue",ylab = "Casos espacialmente rezagados")
title("Gráfico de dispersión de Moran")

infl <- apply(msp$is.inf, 1, any)
x <- datos_sp$dengue
lhx <- cut(x, breaks=c(min(x), mean(x), max(x)), labels=c("L", "H"), include.lowest=TRUE)
wx <- stats::lag(w.11, datos_sp$dengue)
lhwx <- cut(wx, breaks=c(min(wx), mean(wx), max(wx)), labels=c("L", "H"), include.lowest=TRUE)
lhlh <- interaction(lhx, lhwx, infl, drop=TRUE)
cols <- rep(1, length(lhlh))
cols[lhlh == "H.L.TRUE"] <- 2
cols[lhlh == "L.H.TRUE"] <- 3
cols[lhlh == "H.H.TRUE"] <- 4
plot(datos_sp, col=brewer.pal(4, "Accent")[cols])
legend("topright", legend=c("Ninguno", "HL", "LH", "HH"), fill=brewer.pal(4, "Accent"), bty="n", cex=0.8, y.intersp=0.8)
title("Casos de influencia")

rm(msp,cols,infl,lhlh,lhwx,lhx,wx,x)

#Supuestos

m1 <- localmoran(datos_sp$dengue, listw = w.11)
m2 <- as.data.frame(localmoran.sad(lm(dengue ~ 1, datos_sp), nb = nb.1))
m3 <- as.data.frame(localmoran.exact(lm(dengue ~ 1, datos_sp), nb = nb.1))

datos_sp$Normal <- m2[,3]
datos_sp$Aleatorizado <- m1[,5]
datos_sp$Punto_de_silla <- m2[,5]
datos_sp$Exacto <- m3[,5]
gry <- c(rev(brewer.pal(6, "Reds")), brewer.pal(6, "Blues"))

spplot(datos_sp, c("Normal", "Aleatorizado", "Punto_de_silla", "Exacto"), 
       at=c(0,0.01,0.05,0.1,0.9,0.95,0.99,1), 
       col.regions=colorRampPalette(gry)(7))

rm(m1,m2,m3,gry)

datos_sp@data <- datos_sp@data[,c(1:8)]

# Modelos

#Lineal
m1 <- lm(dengue~tugurio+densidad+residuos+acueducto,data = datos_sp)
summary(m1)
step(m1)
m1 <- lm(dengue~residuos+acueducto,data = datos_sp)
lm.morantest(m1, listw = w.11)

#SAR
m2 <- spautolm(dengue~tugurio+densidad+residuos+acueducto,data = datos_sp,listw=w.11)
moran.mc(residuals(m2),w.11, 999)

#CAR
m3 <- spautolm(dengue~tugurio+densidad+residuos+acueducto,data = datos_sp,listw=w.11,family = "CAR")
moran.mc(residuals(m3),w.11, 999)

#Disease Maping
datos_sp$observados <- datos_sp$casos
r <- sum(datos_sp$observados)/sum(datos_sp$pob)
datos_sp$esperados <- datos_sp$pob*r
datos_sp$SMR <- datos_sp$observados/datos_sp$esperados

spplot(datos_sp,"observados")
spplot(datos_sp,"esperados")
spplot(datos_sp,"SMR")

int <- pois.exact(datos_sp$SMR)
int <- cbind(int,datos_sp$NOM_CANT_1)
col <- 1*(int$lower>1)
col <- ifelse(col==0,"grey","red")
linea <- ifelse(col=="grey",4,1) 
plotCI(x = 1:81, y = int$x, ui = int$upper,li = int$lower,pch=18,err="y",
       col=col,sfrac = 0,xlab="Cantones",ylab="Riesgo Relativo",xaxt="n")
abline(h=1,col="grey",lty=2,lwd=1.75)

datos_sp$ch <- choynowski(datos_sp$observados,datos_sp$esperados)$pmap
spplot(datos_sp,"ch")

#Empirical Bayes Estimates
eb1 <- EBest(datos_sp$observados,datos_sp$esperados)
unlist(attr(eb1, "parameters"))
datos_sp$EB_mm <- eb1$estmm

res <- empbaysmooth(datos_sp$observados,datos_sp$esperados)
unlist(res[2:3])
datos_sp$EB_ml <- res$smthrr
eb2 <- EBlocal(datos_sp$observados,datos_sp$esperados, nb.1)
datos_sp$EB_mm_local <- eb2$est


spplot(datos_sp, c("SMR", "EB_ml", "EB_mm", "EB_mm_local"))

