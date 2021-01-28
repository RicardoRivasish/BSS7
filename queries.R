#Ahora es momento de realizar la extracción de una tabla 
#desde un html, realiza este reto desde tu RStudio Desktop.

#De la siguiente dirección donde se muestran los sueldos para Data Scientists

#(https://www.glassdoor.com.mx/Sueldos/data-scientist-sueldo-SRCH_KO0,14.htm), 
#realiza las siguientes acciones:
  
#Extraer la tabla del HTML

library(rvest)

theurl <- "https://www.glassdoor.com.mx/Sueldos/data-scientist-sueldo-SRCH_KO0,14.htm"

file<-read_html(theurl)

tables<-html_nodes(file, "table")

#Quitar los caracteres no necesarios de la columna 
#sueldos (todo lo que no sea número), para dejar solamente la cantidad mensual 
#(Hint: la función gsub podría ser de utilidad)
table1 <- html_table(tables[1], fill = TRUE)


table <- na.omit(as.data.frame(table1))

str(table)

a <- gsub("MXN","",table$Sueldo)
a <- gsub("[^[:alnum:][:blank:]?]", "", a)
a <- gsub("mes", "", a)
a <- as.numeric(a)
table$Sueldo <- a
b <- gsub("Sueldos para Data Scientist en ", "", table$Cargo)
table$Cargo <-b

#Asignar ésta columna como tipo numérico para poder realizar operaciones con ella

#Ahora podrás responder esta pregunta ¿Cuál es la empresa que más paga y la que menos paga?
#Máximo sueldo
max.sueldo <- which.max(table$Sueldo)
table[max.sueldo,]

#Mínimo sueldo
min.sueldo <- which.min(table$Sueldo)
table[min.sueldo,]
