#En este reto guiado por el profesor, vamos a utilizar un conjunto de datos que tenemos por defecto en R, que previamente habremos descargado a un Excel.
#Utilizaremos estos datos de ejemplos para realizar un caso práctico de carga de datos desde un archivo excel para su posterior manipulación.
#También obtendremos datos desde una URL de Wikipedia, para crear un subset o conjunto de datos que "filtraremos" según ciertas condiciones.

library(datasets)
library(openxlsx)
data<-mtcars
write.xlsx(data, file = "datos_mtcars.xlsx")

#El archivo excel no es el mismo que el del reto guiado. 

#Leer el excel mtcars en datos/mtcars.xlsx
library(readxl)
datos<- read_excel(path = "datos/mtcars.xlsx")
head(datos,n=5)
excel_sheets(path = "datos/mtcars.xlsx")              

?mtcars

automaticos <-datos[datos$am==0,]

resumen_at<- automaticos[,c("mpg","cyl","hp","gear")]

datos[datos$model=="Mazda RX4",] #Da error porque en mis datos no tengo el modelo.

#Leer de una web (página de wikipedia)
library(rvest)
url <-"https://en.wikipedia.org/wiki/Men%27s_high_jump_world_record_progression"

page <- read_html(url)
tables <- html_table(html_elements(page,"table"))
table <- tables[[3]]

class(table)
head(table)
tail(table) #Seria aconsejable trabajar y limpiar los datos previamente. 

table$Mark

ny = table[table$Venue=="New York",]
ny

