# Análisis espacial del dengue en Costa Rica 

Este repositorio contiene toda la información referida al último proyecto del curso SP-1649: Tópicos de Estadística Espacial Aplicada, desarrollado por el estudiante de la Maestría Académica en Estadística: Pablo Vivas Corrales(<pablo.vivas@ucr.ac.cr>) para el segundo semestre del 2019. El proyecto cuenta además con un video que se puede visualizar mediante este link: [https://www.youtube.com/watch?v=FHbZQ6Yuass](https://www.youtube.com/watch?v=FHbZQ6Yuass).


## Archivos de repositorio

* Archivos
  * [`Análisis.R`](#análisis)
  * [`Escrito.pdf`](#escrito)
  * [LICENSE](#licencia)

* Carpetas
  * [Bibliografía](#bibliografía)
  * [Datos](#datos)
  * [Figuras](#figuras)
  * [Trabajo escrito](#trabajo-escrito)


### Archivos
---
### Análisis

El archivo `análisis.r` es un documento donde se presenta el código `R` utilizado para generar los resultados de este artículo. Comprende desde la lectura de los datos hasta la creación de los modelos y las figuras. Se utilizó el software R en su versión 3.6.1 (2019-07-05) y el IDE RStudio en su versión 1.2.1335.

### Escrito

Es una copia del archivo `Escrito.pdf` de la carpeta [Trabajo Escrito](#trabajo-escrito) donde se presenta el artículo. Se pone a disposición este archivo, para mayor facilidad en la búsqueda de la versión final este artículo. 

### Licencia

El código usado y presentado en este repositorio tiene una licencia [MIT](https://opensource.org/licenses/MIT)

---
### Carpetas
---
### Bibliografía

En esta carpeta se encuentran archivos `.pdf` que se utilizaron como principales referencias bibliográficas para el proyecto. Estas referencias fueron introducidas al software [Mendeley](https://www.mendeley.com/?interaction_required=true) para crear el archivo `Referencias.bib` de la carpeta [Trabajo Escrito](#trabajo-escrito) utilizado para hacer las citas bibliográficas correspondientes.

### Datos

Aquí se almacenan los datos utilizados en el análisis. Destacan principalmente los siguientes archivos:

* `Cantones`: Información geográfica de la división territorial de Costa Rica en cantones. Esta información se obtuvo de la página [http://daticos-geotec.opendata.arcgis.com](http://daticos-geotec.opendata.arcgis.com/datasets/249bc8711c33493a90b292b55ed3abad_0)
* `Datos cantonales.xlsx`: Compendio de indicadores cantonales que se utilizaron en el análisis, junto con la información espacial. Los indicadores utilizados son:
  * `pob`: Población del 2019. INEC. [LINK](http://services.inec.go.cr/proyeccionpoblacion/frmproyec.aspx)
  * `casos`: Casos de dengue. Ministerio de Salud. [LINK](https://www.ministeriodesalud.go.cr/index.php/vigilancia-de-la-salud/analisis-de-situacion-de-salud)
  * `dengue`: Tasa de Dengue (100.000 habitantes) del 2019. Ministerio de Salud. [LINK](https://www.ministeriodesalud.go.cr/index.php/vigilancia-de-la-salud/analisis-de-situacion-de-salud)
  * `tugurio`: Porcentaje de viviendas de tipo tugurio en el 2011. INEC. [LINK](http://sistemas.inec.cr:8080/bincri/RpWebEngine.exe/Portal?BASE=2011&lang=esp)
  * `densidad`: Densidad de la población del 2011. INEC. [LINK](http://sistemas.inec.cr:8080/bincri/RpWebEngine.exe/Portal?BASE=2011&lang=esp)
  * `residuos`: Porcentaje de viviendas que eliminan los residuos sólidos por camión recolector en el 2011. INEC. [LINK](http://sistemas.inec.cr:8080/bincri/RpWebEngine.exe/Portal?BASE=2011&lang=esp)
  * `acueducto`: Porcentaje de viviendas con acueducto en el 2011. INEC. [LINK](http://sistemas.inec.cr:8080/bincri/RpWebEngine.exe/Portal?BASE=2011&lang=esp)

### Figuras

Contiene las figuras creadas en la investigación. Se describe cada una de ellas: 

* `Figura 1.pdf`: 
* `Figura 2.pdf`: 
* `Figura 3.pdf`: 
* `Figura 4.pdf`: 
* `Figura 5.pdf`: 
* `Figura 6.pdf`: 
* `Figura 7.pdf`: 
* `Figura 8.pdf`: 
* `Figura 9.pdf`: 
* `Figura 10.pdf`: 

### Trabajo Escrito

En esta carpeta se almacenan todos los archivos necesarios para la creación del documento `Escrito.pdf`. Estos archivos se crearon mediante el software [TexMaker](https://www.xm1math.net/texmaker/)

---

