#En este reto guiado utilizaremos el paquete de PimaIndiansDiabetes2, para predecir si una persona es diabética o no. Es decir, estaremos realizando una una tarea de clasificación.
# Para ello vamos a entrenar dos modelos distintos basados en dos algoritmos diferentes:KNN y Regresión logística
#El algoritmo KNN los indicará si una persona es diabética o no en función a los vecinos cercanos. Si los vecinos cercanos son diabéticos, establecerá que la variable a evaluar también lo es.
#El modelo de regresión logística se basa en que la variable de respuesta es dicotómica o binaria, es decir, tiene dos categorías posibles. En este caso sí o no.

library(caret)
library(dplyr)

#Cargar los datos
data(package = "mlbench", PimaIndiansDiabetes2)
head(PimaIndiansDiabetes2)
summary(PimaIndiansDiabetes2)

#Limpieza de datos
data<- PimaIndiansDiabetes2 %>% select(pregnant, glucose, pressure, mass, pedigree,age,diabetes) %>%
  na.omit()

#Separamos los datos en dos conjuntos
set.seed(478)
index <- createDataPartition(data$diabetes,
                             p=0.7,
                             list=FALSE)
index
train_set <- data[index,]
test_set <- data[-index,]

#KNN
modelLookup("knn")

ctrl = trainControl(method = "cv", number = 8, verboseIter = TRUE)
knn_params = expand.grid(k=c(2:20))

knn_model <- train(diabetes~.,
                   data= train_set,
                   method = "knn",
                   trControl =  ctrl,
                   tuneGrid = knn_params)
knn_model

plot(knn_model) #Representamos el modelo

#Predicciones de KNN

knn_predict <- predict(knn_model,test_set)
confusionMatrix(knn_predict,test_set$diabetes)

summary(test_set$diabetes) #neg pos 142  74 

#Regresión Logística
modelLookup("glm")

glm_model <- train(diabetes~.,
                  data = train_set,
                  method = "glm",
                  trControl = ctrl,
                  )

glm_model

#Predicciones de regresión logística
glm_predict <- predict(glm_model,test_set)
confusionMatrix(glm_predict, test_set$diabetes)

#Para evaluar qué modelo se comporta mejor para este escenario, mediremos qué modelo detecta el mayor número de casos positivos. Para ello tendremos que fijarnos en el valor de "Specificity" o especificidad de la matriz de confusión.
#A través del análisis de los valores que nos ofrece la matriz de confusión, podemos ver que el modelo de regresión logística se comporta mejor que el modelo de KNN, ya que obtenemos un valor superior de especificidad, indicando que detecta mayor número de positivos.

