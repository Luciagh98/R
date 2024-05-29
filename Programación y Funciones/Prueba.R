saludo <- function() {
  print("Hola, bienvenido a R")
}
saludo() 

calificar_edad <- function(edad) {
  if (edad < 18) {
    print("Menor de edad")
  } else {
    print("Mayor de edad")
  }
}
calificar_edad(14) 


tabla_multiplicar <- function(n) {
  for (i in 1:10) {
    resultado <- n * i
    print(paste(n, "x", i, "=", resultado))
  }
}
tabla_multiplicar(10)

numeros_pares <- function(limite) {
  pares <- c()
  for (i in 1:limite) {
    if (i %% 2 == 0) {
      pares <- c(pares, i)
    }
  }
  print(pares)
}
numeros_pares(20)

matriz_cuadrada <- function(n) {
  matriz <- matrix(0, nrow = n, ncol = n)
  for (i in 1:n) {
    for (j in 1:n) {
      matriz[i, j] <- i + j
    }
  }
  print(matriz)
}
matriz_cuadrada(3)
