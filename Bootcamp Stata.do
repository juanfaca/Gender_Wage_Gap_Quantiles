* Akademo
* 8 de setiembre de 2023

*1. Comandos preliminares

clear all
set more off

* Usamos STATA como una calculadora 
display 4+5
display sqrt(8)
display log(10)

* Asignación de valores
scalar x=4+3

* Evaluando proposiciones (tambien admite variables)
assert x==3
assert x!=5

* Lista de Escalares
scalar list

*** ================================ PRIMERA PARTE: ENAHO ================================== ***

* Ver 
pwd 

* Establecer el directorio:
cd "C:\Users\User\Desktop\Cursos Varios\Akademo"
pwd

* Lista de archivos en el directorio actual
dir

* Filtrar solo los achivos de Stata
dir *.dta

*-------------------------------------------------------------
* 	Dimensión: módulo 500 - Empleo e ingresos 
*-------------------------------------------------------------
*Comandos básicos

* Abrimos base enaho
use "enaho01a-2022-500.dta", clear

* Describe permite explorar un poco la base de datos. Podemos ademas agregar opciones como simple o short
describe
describe, simple
d, short

* Ver la base de datos
browse
br

* Summarize nos da estadistica descriptiva
summarize i513t
summarize i513t, detail			// Version detallada. Incluye percentiles, asimetria, curtosis

bysort p207: sum i513t		
bysort estrato: sum p208a// Realiza un sum de edad para cada categoria de la clase estrato

tabulate p208a
tabulate estrato

*Crear histograma de variables
histogram i513t


* Buscar paquetes para instalar: findit <paquete>. Si ya sabemos el nombre, entonces:
*ssc install inequal7

* Para que nuestras variables esten en el formato mas adecuado que ayude a ahorrar espacio:
compress

* Podemos pedir a Stata que cuente las observaciones que cumplen ciertas características. En este caso edad mayor a 25. Otros que no contienen observación en variable de género
count if p208a>25
count
count if missing(p207)
count if missing(p521a)


* Con codebook vemos mas informacion detallada sobre una variable
codebook estrato

* Sort y gsort sirven para ordenar las observaciones de la base
sort p207
gsort -p207


*------------------------ Se replica una regresión ------------------------------*
*------------------------   MCO, MCR, Cuantílica   ------------------------------*

*-------------------------------------------------------------
* Recodificación de los módulos de la Enaho
*-------------------------------------------------------------
/*
clear all
unicode analyze enaho01a-2022-500.dta
unicode encoding set "latin1"
unicode translate enaho01a-2022-500.dta
*/

*Para sacar la muestra y población
tab ocu500 if ocu500<4 & ocu500>0 [iw=fac500a]
tab ocu500 if ocu500<4 & ocu500>0, nol
tab ocu500

*Tenemos que quedarnos con los que trabajan
drop if ocu500!=1

rename aÑo año
keep año i524a1 p301a p207 estrato ocupinf p208 fac500a p513t
rename i524a1 ingreso 

*Generar variable rural o urbano 
tab estrato

*urbano=1 si es area urbana y urbano=0 si es area rural 
gen urbano=1 if estrato<7
replace urbano=0 if estrato>6
drop estrato
rename p208a edad 

*hombre=1 si es hombre, hombre=0 si es mujer 
gen hombre=1 if p207==1
replace hombre=0 if p207==2 
drop p207

*escolaridad es 0 cuando es sin nivel, inicial y primaria incompleta
gen escolaridad=0 if p301a<4
*escolaridad es 1 cuando es primaria completa y secundaria incompleta
replace escolaridad=1 if p301a>3 & p301a<6
*escolaridad es 2 cuando es secundaria completa y superior no universitaria incommpleta
replace escolaridad=2 if p301a>5 & p301a<8
*escolaridad es 3 cuando es sup no univ completa y sup univ incompleta
replace escolaridad=3 if p301a>7 & p301a<10
*escolaridad es 4 cuando es sup univ completa y post grado
replace escolaridad=4 if p301a>9
drop p301a

*horas trabajadas a la semana
rename p513t horas
*ocupacion informal
tab ocupinf
tab ocupinf, nol
*formal=1 si es formal, formal=0 si es informal
gen formal=1 if ocupinf==2
replace formal=0 if ocupinf==1
drop ocupinf
rename i524a1 ingreso
rename ingreso salario
replace salario=salario/12
gen logsal=log(salario)
gen edadsq=edad^2

*LABELS
label var urbano "=1 si es zona urbana"
label var hombre "=1 si es hombre"
label var escolaridad "más grande si tiene más educación"
label var formal "=1 si es formal"
label var logsal "logaritmo de salario"
label var edadsq "edad al cuadrado"
label var salario "salario mensual"

//// Etiquetas
label define hombre_label 0 "Mujer" 1 "Hombre"
label values hombre hombre_label

label define urbano_label 0 "Rural" 1 "Urbana"
label values urbano urbano_label

label define escolaridad_label 0 "[sin nivel - prim. incompleta]" 1 "[prim. completa - sec. incompleta]" 2 "[sec. completa - sup. no univ incompleta]" 3 "[sup. no univ completa - sup. univ incompleta]" 4 "[sup. univ. completa - posgrado]"
label values escolaridad escolaridad_label

label define formal_label 0 "Informal" 1 "Formal"
label values formal formal_label


tabstat escolaridad [aw=fac500a], by(hombre)
tabstat formal [aw=fac500a], by(hombre)

bysort hombre: sum salario, detail
bysort hombre: sum salario, detail

tabstat salario [aw=fac500a], by(hombre) statistics(mean p10 p25 p50 p75 p95)
tabstat escolaridad [aw=fac500a], by(hombre) statistics(mean p10 p25 p50 p75 p95)
sum salario [iw=fac500a]
histogram salario , by(hombre)

*Adicionales. Eliminación de datos extremos

*Con esto se instala el comando winsor
findit winsor 
histogram logsal
winsor logsal, gen(winsor_logsal) p(0.05)
graph box winsor_logsal, over(hombre)

br

*Regresión normal
reg logsal edad edadsq horas urbano hombre i.escolaridad formal [iw=fac500a]
*Regresión corregida
reg logsal edad edadsq horas i.urbano i.hombre i.escolaridad i.formal [iw=fac500a], vce(robust)
*Regresión común cuantílica
bsqreg logsal edad edadsq horas i.urbano i.hombre i.escolaridad i.formal, q(0.75) reps(100)


*Regresion cuantílica
sqreg logsal edad edadsq horas i.urbano i.hombre i.escolaridad i.formal, q(0.1 0.25 0.5 0.75 0.95) reps(100)