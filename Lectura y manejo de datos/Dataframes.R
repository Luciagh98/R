#cREAR UN DATAFRAME

df<-data.frame(id = 1:4,
               nombres = c("Ana","Belen","Carlos","Daniel"),
               notas = c(8.5,7,4,9.2))
df

df2 <- data.frame(1:10,5:10) #Error en data.frame(1:10, 5:10): 
#los argumentos implican un número diferente de filas: 10, 6

#PROPIEDADES
class(df) #"data.frame"
dim(df) #4 observaciones y 3 columnas
length(df) #3
ncol(df) #3
nrow(df) #4

#INFORMACION
names(df) #[1] "id"      "nombres" "notas" 
head(df,n=2)
tail(df,n=2)
summary(df) #Resumen
str(df) #Resumen más detallado

#ACCEDER A CADA ELEMENTO
df$nombres
df[[3]]
df[1,]
df[,2]
df[3,3]

#AÑADIR NUEVOS ELEMENTOS
df$edad<-c(20,32,28,40)
dim(df)
df$aprobado <- c(TRUE,TRUE,FALSE) #Cada vector tiene que tener el mismo tamaño
df <- cbind(df, aprobado = c(TRUE,TRUE,FALSE,TRUE)) #Añadir columnas
ncol(df)

#ELIMINAR ELEMENTOS
df$aprobado<-NULL
dim(df)

#RENOMBRAR COLUMNAS
names(df)
names(df)[2] <- "Nombres y Apellidos"
names(df)

#COERCIÓN DE LOS DATOS
df_numeros <- data.frame(A=1:10,B=11:20)
mat <- as.matrix(df_numeros)
mat
class(mat)
mat2<-as.matrix(df)
mat2 #COnvierte todo al mismo tipo de datos

df_numeros2 <- as.data.frame(mat)
class(df_numeros2)
df_numeros2
