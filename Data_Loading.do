
*** ================================ Loading Data ================================== *** 

* Set directory:
cd "C:\Users\User\Your Directory"
pwd

* Filter .dta files
dir *.dta

* Abrimos base enaho
use "enaho01a-2021-500.dta", clear

* Describe data
describe, simple
d, short

* View
browse
br

*** =============== Creating Peruvian Laboral Market dataset ======================== *** 

*-------------------------------------------------------------
* ENAHO Modules recodification
*-------------------------------------------------------------

/* (Just use this at first time)
clear all
unicode analyze enaho01a-2021-500.dta
unicode encoding set "latin1"
unicode translate enaho01a-2021-500.dta
*/

*-------------------------------------------------------------
* Adjusting variables
*-------------------------------------------------------------

*Filtering people who don't work
tab ocu500
tab ocu500, nol
drop if ocu500!=1

*Rename some variables
rename aÑo año
rename i524a1 ingreso
rename p208a edad
rename p513t horas

*Keeping important variables
keep año ingreso p301a p207 estrato ocupinf edad fac500a horas

*Generating variable of area
tab estrato

gen urbano=1 if estrato<7
replace urbano=0 if estrato>6
drop estrato

*Adjusting gender variable
gen hombre=1 if p207==1
replace hombre=0 if p207==2
drop p207

*Adjusting variable of education level

gen escolaridad=0 if p301a<4
replace escolaridad=1 if p301a>3 & p301a<6
replace escolaridad=2 if p301a>5 & p301a<8
replace escolaridad=3 if p301a>7 & p301a<10
replace escolaridad=4 if p301a>9
drop p301a

*Formal/informal job variable


tab ocupinf
tab ocupinf, nol
gen formal=1 if ocupinf==2
replace formal=0 if ocupinf==1
drop ocupinf

*Income variable

rename ingreso salario
replace salario=salario/12
gen logsal=log(salario)
gen edadsq=edad^2

*-------------------------------------------------------------
* Labelling variables and values
*-------------------------------------------------------------

//// Variables
label var urbano "=1 si es zona urbana"
label var hombre "=1 si es hombre"
label var escolaridad "nivel educativo"
label var formal "=1 si es formal"
label var logsal "logaritmo de salario"
label var edadsq "edad al cuadrado"
label var salario "salario mensual"

//// Values
label define hombre_label 0 "Mujer" 1 "Hombre"
label values hombre hombre_label

label define urbano_label 0 "Rural" 1 "Urbana"
label values urbano urbano_label

label define escolaridad_label 0 "[sin nivel - prim. incompleta]" 1 "[prim. completa - sec. incompleta]" 2 "[sec. completa - sup. no univ incompleta]" 3 "[sup. no univ completa - sup. univ incompleta]" 4 "[sup. univ. completa - posgrado]"
label values escolaridad escolaridad_label

label define formal_label 0 "Informal" 1 "Formal"
label values formal formal_label

//// Save the final dataset. Next Steps in Python
*Regresion cuantílica
sqreg logsal edad edadsq horas i.urbano i.hombre i.escolaridad i.formal, q(0.1 0.25 0.5 0.75 0.95) reps(100)
