#En este reto guiado, aplicaremos los conocimientos aprendidos con ggplot2, en el que construiremos diferentes tipos de gráficos como un histograma, gráfico de barras, boxplot o un gráfico de dispersión.
#Vamos a utilizar la librería mlbench, de la cual utilizaremos el set de datos mpg que nos proporciona información de coches más populares en un periodo de tiempo.

library(ggplot2)
library(mlbench)
library(stringr)
library(dplyr)

?mpg
head(mpg,n=5)

#Histograma
ggplot(mpg, aes(x=cyl))+
  geom_histogram(binwidth=2,color = "red",fill = "blue") + 
  labs(title = "Histograma: coches por cilindrada",
       x="Cilindros",
       y="Nº de coches")
#Hemos creado un histograma del número de vehículos categorizados por cilindrada.

#Gráfico de barras
ggplot(mpg,aes(x=class)) + 
  geom_bar(aes(fill=manufacturer)) + 
  labs(title = "Distribución de coches por clase",
       x="Clase",
       y="Nº de coches") + 
  theme(panel.background = element_blank()) +
  theme(plot.title = element_text(color="red")) + 
  theme(legend.position = "none")

#Un digrama de barras del número de vehículos por clase o tipo, que además se muestra la división por colores según el fabricante.


#BoxPlot
mpg$trans <- mpg$trans %>% str_sub(1,-5)

ggplot(mpg,aes(x=trans,y=cty)) + 
  geom_boxplot(aes(fill=trans))+
  labs(title = "Boxplot: Consumo por tipo de transmisión",
       x="Transmisión",
       y="Consumo urbano")+
  theme(legend.position = "none")+
  theme(panel.background = element_blank())

#En el gráfico boxplot hemos unificado todos los tipos de transmisión automática a uno sólo, así como los de transmisión manual, permitiendo tener una visualización mucho más clara.

#Gráfico de dispersión
ggplot(mpg,aes(x=cty,y=hwy))+
  geom_point(aes(color=trans,size=cyl))

##Finalmente en el gráfico de dispersión, podemos ver la relación entre dos variables, en este caso entre la transmisión y la cilindrada.

#Facetado
ggplot(mpg,aes(x=year,y=hwy))+
  geom_point(aes(color=class,size=cyl))+
  facet_wrap(~trans)

#Además, hemos aplicado el facetado a este gráfico, de forma que hemos añadido una capa adicional de agrupación por clase de tipo de vehículo.


#Esto nos permite visualizar sin necesidad de herramientas adicionales nuestros datos y extraer conocimiento de ellos.
