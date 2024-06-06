#En este reto guiado partiermos de un set de datos que ofrece R, en particular del set de diamantes.
#Vamos a guardar este set de datos en un CSV y con un código ya elaborado, aplicaremos diferentes técnicas de optimización para mejorar el código planteado.

library(readr)
library(ggplot2)
library(profvis)

profvis({
path <- "datos/diamonds.csv" #Obtengo el csv en inglés
datos <- read_csv(path)

resultados <- list()

cortes <- unique(datos$cut)

for (i in 1:length(cortes)){
  seleccion <- datos[datos$cut == cortes[i],]
  media <- mean(seleccion$price)
  resultados[[i]] <- data.frame(Corte=cortes[i], Media = media)
}

resumen_diamonds <- do.call(rbind,resultados)

ggplot(resumen_diamonds, aes(x=Corte, y=Media)) + 
  geom_col()+
  geom_text(aes(label=Media))
})