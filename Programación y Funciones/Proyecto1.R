#Proyecto
#Creación de funciones personalizadas para analizar un conjunto de datos.
#Imagina que trabajamos para una empresa en la que necesitamos saber el salario 
#bruto, neto y si el trabajador hay realizado horas extras.
#Para ello definiremos una función en la que pasándole el número de horas 
#trabajadas, el salario por hora y la retención, nos devuelva los valores 
#indicados anteriormente.

salario <- function(costehora, horas = 40, retenciones = 0.02) {
  if(horas>45){
    horasextras = horas - 45
    costeextra = costehora * 1.5
    bruto = 45 * costehora + horasextras * costeextra
    neto = bruto * (1-retenciones)
  }else {
    bruto = horas * costehora
    neto = bruto * (1 - retenciones)
  }
  return(list("Salario Bruto" = bruto,"Salario Neto" = neto))
}

salario(20)
salario(20,50,0.20)

#Modificaciones posteriores:
salario <- function(costehora, horas = 40, retenciones = 0.02) {
  if(horas>45){
    horasextras = horas - 45
    costeextra = costehora * 1.5
    bruto = 45 * costehora + horasextras * costeextra
  }else {
    bruto = horas * costehora
  }
  neto = bruto * (1-retenciones)
  return(list("Salario Bruto" = bruto,"Salario Neto" = neto))
}

#Aplicaciones con bucles for:

media <- function(x){
  resultado <- 0
  for(i in 1:length((x))){
    resultado <- resultado + x[i]
  }
  resultado/length(x)
}

media(1:11)

#Aplicaciones en un bulce while
media <- function(x){
  resultado <- 0
  i <- 1
  while(i <= length(x)){
    resultado <- resultado + x[i]
    i <- i +1
  }
  resultado / length(x)
}

media(1:11)
media(20:30)

#Vectorización de operaciones
media<- function(x){
  sum(x) / length(x)
}

media(20:30)
