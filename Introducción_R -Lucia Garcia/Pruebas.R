
numero <- 10
nombre <- "Lucia"

clase <- class(numero)
es_numerico <- is.numeric(numero)

suma <- numero + (2 * numero)

edades <- c(27, 47, 18)
informacion <- list(nombre = "David", edad = 27)

es_caracter <- is.character(nombre)
es_logico <- is.logical(es_numerico)

mayor_de_edad <- edades[1] >= 18

aparece <- 30 %in% edades

comparar <- (2 * numero) > edades[3]

condicion1 <- TRUE
condicion2 <- TRUE
comprovacion <- condicion1 & condicion2
print(comprovacion)

verdadero <- TRUE
comprovacion2 <- !verdadero
print(comprovacion2)
