#En este reto guiado, utilizaremos del paquete mlbench, el set de datos PimaIndiansDiabetes2, para realizar un análisis estadístico y determinar la relación entre distintas variables.
#En primer lugar aplicaremos técnicas de estadística descriptiva para comprender la naturaleza a nuestros datos, así como tests estadísticos que confirmarán la relación o no entre variables y nivel de significación.
library(dplyr)

data(package="mlbench",PimaIndiansDiabetes2)
head(PimaIndiansDiabetes2,n=10)

#DATOS BÁSICOS
mean(PimaIndiansDiabetes2$glucose,na.rm=TRUE)
sd(PimaIndiansDiabetes2$glucose,na.rm=TRUE)

#RESUMEN DE TODO (GLUCOSA)
summary(PimaIndiansDiabetes2$glucose)

#VALORES EN TABLAS
table(PimaIndiansDiabetes2$diabetes)
prop.table(table(PimaIndiansDiabetes2$diabete))

#RESUMEN DE TODO
summary(PimaIndiansDiabetes2)

#HISTOGRAMA
hist(PimaIndiansDiabetes2$glucose)

#PLANTEAMIENTO DE HIPÓTESIS
t <- t.test(glucose ~ diabetes, data = PimaIndiansDiabetes2)
print(t)

#CORELACIÓN
datos <- PimaIndiansDiabetes2 %>% na.omit()
cor(datos$glucose, datos$pressure)

#Utilizaremos otro set de datos, mtcars, para realizar un análisis estadístico con representaciones más complejas en ggplot2, en el que probaremos la validez de la hipótesis nula o alternativa.
library(readxl)
library(dplyr)
library(ggplot2)

data()
mtcars

# Instalar y cargar el paquete openxlsx
install.packages("openxlsx")
library(openxlsx)

# Exportar el dataframe mtcars a un archivo Excel
write.xlsx(mtcars, "C:/Users/PrincesaPolar/OneDrive/Documentos/Análisis Estadístico/Datos/mtcars.xlsx")

raw <- read_excel("C:/Users/PrincesaPolar/OneDrive/Documentos/Análisis Estadístico/Datos/mtcars.xlsx")

head(raw)
summary(raw)

clean <- raw %>% select(mpg,cyl,disp,hp,wt,am) %>% 
  mutate(am = factor(am,level = c(0,1), labels = c("Automático","Manual")),
         cyl = as.factor(cyl))
summary(clean)

#RELACIÓN ENTRE CONSUMO Y VARIABLES NUMÉRICAS
correlation <- cor(clean[,c("mpg","disp","hp","wt")])
correlation
pairs(clean[,c("mpg","disp","hp","wt")])

#RELACIÓN ENTRE EL TIPO DE TRANSMISIÓN CON LA EFICIENCIA DEL COCHE
ggplot(data=clean,aes(x=am,y=mpg, fill = am)) + 
  geom_boxplot()+
  labs(title ="Relación entre consumo y tipo de transmisión",
       x="Tipo de transmisión",
       y="Consumo(millas por galón)")

#RELACIÓN ENTRE LOS CILINDROS CON LA EFICIENCIA DEL COCHE
ggplot(data=clean,aes(x=cyl,y=mpg, fill = cyl)) + 
  geom_boxplot()+
  labs(title ="Relación entre consumo y tipo de cilindros",
       x="Tipo de cilindros",
       y="Consumo(millas por galón)")

#PARA TRANSMISIÓN
t <- t.test(mpg~am, data = clean)
t

#PARA CILINDROS
anova <- aov(mpg ~cyl, data=clean)
summary(anova)

#MODELO DE REGRESIÓN LINEAL
model<- lm(mpg ~ hp + disp + wt, data=clean)
summary(model)
