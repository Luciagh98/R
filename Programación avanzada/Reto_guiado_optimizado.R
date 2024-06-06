#Resultado final después de optimizar:

library(readr)
library(ggplot2)
library(profvis)
library(dplyr)

profvis({path <- "datos/diamonds.csv" #Obtengo el csv en inglés
datos <- read.csv(path)
  
resumen_diamonds <- datos %>% group_by(cut) %>%
  summarise(Media = mean(price))

resumen_diamonds
  
ggplot(resumen_diamonds, aes(x=Corte, y=Media)) + 
  geom_col()+
  geom_text(aes(label=Media))
})