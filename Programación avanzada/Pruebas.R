microbenchmark::microbenchmark({
  datos <- read_csv(path)
},
{
  datos <- read.csv(path)
}
)

#                            expr      min       lq     mean   median       uq
#{     datos <- read_csv(path) } 144.7111 171.1849 213.5357 187.4081 223.6995
#{     datos <- read.csv(path) } 241.1263 263.7107 321.8992 291.1582 341.7280
#max neval
#732.9461   100
#791.0314   100

system.time(read_csv(path))
system.time(read.csv(path))

#   user  system elapsed 
#0.23    0.03    0.21 
#> system.time(read.csv(path))
#user  system elapsed 
#0.45    0.03    1.14 

microbenchmark::microbenchmark({
  resumen_diamonds <- datos %>% group_by(cut) %>%
    summarise(Media = mean(price))
},
{
  resultados <- list()
  
  cortes <- unique(datos$cut)
  
  for (i in 1:length(cortes)){
    seleccion <- datos[datos$cut == cortes[i],]
    media <- mean(seleccion$price)
    resultados[[i]] <- data.frame(Corte=cortes[i], Media = media)
  }
  
  resumen_diamonds <- do.call(rbind,resultados)
}
)
#   min      lq     mean   median       uq     max neval
#4.9602  5.7906 12.27319  7.20475 12.00365  85.858   100
#15.5369 18.4679 31.32255 22.78815 33.45210 181.891   100

