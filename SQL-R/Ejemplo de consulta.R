install.packages("RSQLite")
library(RSQLite)
library(DBI)
library(dplyr)

data(package="mlbench", PimaIndiansDiabetes2)

#Nombrar la base de datos
db <- "PimaIndians.bd"

#Crear la conexión a la BD
con <- dbConnect(SQLite(),dbname = db)
dbListTables(con) #Lista con los nombres de las tablas de la BD

#Almacenar el dataset PimaIndians en nuestra base de datos
dbWriteTable(conn = con,
             name = "Pima",
             value = PimaIndiansDiabetes2)
dbListTables(con)

#Realizar consultas SQL a nuestra BD
#Obtener los casos con diabetes = pos
query1 <- "SELECT * FROM Pima WHERE diabetes = 'pos'"
resultados <- RSQLite::dbGetQuery(conn = con,
                                  statement = query1)

resultados
class(resultados) #Devuelve un dataframe
table(resultados$diabetes) #Para comprovar que solo muestra los positivos

#Obtener los casos con glucosa mayor de 160 y edad mayor de 50
query2 <- "SELECT * FROM Pima WHERE glucose > 160 and age > 50"
resultados2 <- RSQLite::dbGetQuery(conn = con,
                                  statement = query2)

resultados2
table(resultados2$diabetes)

#Obtener solo la glucosa, el nº de embarazos y imc de los casos 
#con diabetes = pos y glucosa > 180
query3 <- "SELECT glucose,pregnant,mass FROM Pima WHERE glucose > 180 and diabetes = 'pos'"
resultados3 <- RSQLite::dbGetQuery(conn = con,
                                   statement = query3)

resultados3
summary(resultados3$glucose)

#-------------------------------------------

tbl(src = con, "Pima")

#DPLYR
#Obtener los casos con diabetes = pos
q1 <- tbl(src = con, "Pima") %>% filter(diabetes == "poss")

show_query(q1)

resultadosq1 <- q1 %>% collect()

#Obtener los casos con glucosa mayor de 160 y edad mayor de 50
q2 <- tbl(src = con, "Pima") %>%
  filter(age > 50 , glucose > 160)

show_query(q2)
resultadosq2 <- q2 %>% collect()

#Obtener solo la glucosa, el nº de embarazos y imc de los casos 
#con diabetes = pos y glucosa > 180
q3 <- tbl(src = con, "Pima") %>% filter(diabetes == "pos", glucose > 180) %>% 
  select(glucose,pregnant,mass)

show_query(q3)
resultadosq3 <- q3 %>% collect()
q3

class(resultadosq3)
class(q3)

# Cerrar la conexión a la base de datos
dbDisconnect(con)
