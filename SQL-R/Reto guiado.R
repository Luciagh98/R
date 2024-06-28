#En este reto guiado crearemos una base de datos SQLite, con información de población de la Organización Mundial de la Salud, sobre la tuberculosis.
#Extraeremos los datos mediante consultas y los analizaremos.
#Para ello utilizaremos el paquete RSQLite y dbplyr para establecer la equivalencia del mismo proceso con ambos paquetes.

library(RSQLite)
library(tidyverse)
library(DBI)

#Nombrando la base de datos
db <- "tuberculosos.db"

#Crear la conexión
con <- dbConnect(SQLite(), dbname = db)
dbListTables(con)

#Añadir información a la BD
dbWriteTable(conn = con, 
             name = "population",
             value = population)

dbWriteTable(conn = con, 
             name = "who",
             value = who)

dbListTables(con)
tbl(con, "population")
tbl(con,"who")

#Construir nuestra sentencia SQL
select <- "SELECT who.year, who.country, who.new_sp_f4554, population.population"
from <- "FROM who"
left_join <- "LEFT JOIN population on who.country = population.country and who.year = population.year"
where <- "WHERE (who.country = 'Spain' or who.country = 'Mexico') and (who.year >= 201 and who.year<= 2008)"

query <- paste(select,from, left_join, where)
query

resultados <- RSQLite::dbGetQuery(con,query)
class(resultados)
resultados

#Usando dplyr
q1 <- tbl(con, "who") %>%
  filter(country %in% c("Spain","Mexico"),year >= 2001, year <= 2008) %>%
  select("country","year","new_sp_f4554") %>%
  left_join(y = tbl(con,"population"), by = c("country","year"))%>%
  group_by(country, year) %>% 
  summarise("Casos por millón" = new_sp_f4554/population * 1000000)

show_query(q1)

resultados2 <- q1 %>% collect()
class(resultados2)
resultados2

resultados3 <- q1 %>% collect()
class(resultados3)
resultados3

