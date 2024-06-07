#En este reto guiado, vamos a extraer información de una URL de Wikipedia, en este caso del récord de salto masculino.
#El objetivo de este reto es crear un dataframe con los campos Record, Atleta, País, Fecha del record, año del record, mes del record, día del record, tiempo transcurrido hasta hoy desde el record y la ciudad donde tuvo lugar.
#Para ello tendremos que manipular previamente los datos extraídos, tanto a nivel de fecha como de cadenas de texto para eliminar inconsistencias y realizar las operaciones necesarias a partir de los datos orifinales, para obtener los datos que queremos en el dataframe.

#Librerias
library(rvest)
library(stringr)
library(lubridate)

#Origen de los datos
url<- "https://en.wikipedia.org/wiki/Men%27s_high_jump_world_record_progression"
page<- read_html(url)
tablas <- html_table(html_elements(page,"table"))
raw <- as.data.frame(tablas[3])
summary(raw)

#Transformar los datos
#METROS
head(raw)
meters <- str_sub(raw$Mark,1,4)
head(meters)
class(meters)
meters <- as.numeric(meters)
class(meters)

#PAÍS
country <-str_sub(raw$Athlete,-4,-2)
head(country)

#ATLETA
athlete <-str_sub(raw$Athlete,1,-6)
head(athlete)
athlete <- str_trim(athlete)
head(athlete)
athlete <- str_to_upper(athlete)
head(athlete)

#FECHAS
dates <- raw$Date
head(dates)
dates <- str_replace(dates, "\\[[1-9]\\]","")
head(dates,n=5)
class(dates)

dates <- dmy(dates)
dates

year <- year(dates)
head(year)
month <- month(dates)
head(month)
day <- day(dates)
head(day)

#RECORD
record_time_elapsed <- year(today()) - year(dates)
head(record_time_elapsed)
clean_data <- data.frame("Record" = meters,
                         "Athlete" = athlete,
                         "Country" = country,
                         "Record Date" = dates, 
                         "Record Year" = year,
                         "Record Month" = month,
                         "Record Day" = day, 
                         "Record Time Elapsed" = record_time_elapsed,
                         "City" = raw$Venue
                         )

#Libreria
library(dplyr)

head(clean_data,n=5)

#Aplicamos las modificaciones que nos interesan
info <- clean_data %>% mutate ("Multiples Records" = ifelse(duplicated(Athlete), TRUE, FALSE)) %>%
  select(Record, Athlete, Record.Year, "Multiples Records", Country)

info <- clean_data %>% select(Record, Athlete, Record.Year, Country) %>%
      filter(Record >= 2.30) %>% group_by(Country) %>%
      summarise("maxRecord" = max(Record), "N. of Records" = n()) %>% arrange(desc(maxRecord))

info
#Elemento importante e interesante -> %>%
