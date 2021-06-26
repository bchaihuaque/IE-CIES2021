********************************************************************************
* INTRODUCCIÓN A LA EVALUACIÓN DE IMPACTO - CIES
* TEMA		: ASIGNACIÓN ALEATORIA
* PROFESOR	: STANISLAO MALDONADO
* ALUMNO	: BRUNO CHAIHUAQUE DUEÑAS
* FECHA		: 19/06/2021
* LINK		: https://github.com/bchaihuaque/IE-CIES2021
********************************************************************************
set more off // para mostrar mejor los resultados de tablas largas
// Datos educativos de Loreto (2011)
// definindo la carpeta de trabajo
cd "D:\Estudiando\Evaluacion_Impacto\Impact_Evaluation_CIES\SesionPractica2"
/* setting the seed:
Setting the seed
https://stats.idre.ucla.edu/stata/faq/how-can-i-draw-a-random-sample-of-my-data/
When taking a random sample of your data, you may want to do so in a way that 
is reproducible. In other words, you can generate the same sample if you need 
to. To do this, you will need to set the seed.  The seed is the number with 
which Stata (or any other program) starts its algorithm to generate the 
pseudo-random numbers.  If you do not set the seed, Stata will start its 
algorithm with the seed 123456789.  To set the seed, use the set seed command 
followed by a number.  The number can be very large, including 30 or more 
digits. Remember to do this in a .do file or to write the seed number down 
somewhere.  Please see the Stata Data Management Manual for more information.

p.e: set seed 2038947

*/
set seed 54321
use "/home/bchaihuaque/Dropbox/data/Base_Educacion_Loreto_2011.dta", clear
* use "Base_Educacion_Loreto_2011.dta"
describe

////////////////////////////////////////////////////////////////////////////////
* 1. SIMPLE RANDOM ASSIGMENT
////////////////////////////////////////////////////////////////////////////////

* A. MANUAL APPROACH

*Paso 1: genera una variable "random" uniformemente distribuida
gen random = uniform()
*Paso 2: Ordenando por "random"
sort random
*Paso 3: creando la variable tratamiento (1=tratado/0=control)
gen treatment_simple = 0
replace treatment_simple = 1 if _n<=_N/2
/* Ojo: _n es el número de observación y _N es el total de observaciones, tal 
como explican en este link:
https://stats.idre.ucla.edu/stata/seminars/notes/counting-from-_n-to-_n/
*/
*Paso 4: estadísticas descriptivas
tabstat m500_c_11 m500_m_11 incidencia_pobreza_total incidencia_pobreza_extrema gini gasto_pc, by(treatment_simple) s(mean sd)
/* tabstat genera una tabla que por defecto muestra la media, pero le añadimos s(mean sd) para
que muestre también la desviación estándar
estas son las variables que muestra: 
m500_c_11 : medida de comprensión lectora
m500_m_11 : medida de matemáticas
incidencia_pobreza_total
incidencia_pobreza_extrema
gini
gasto_pc
*/
/* COMENTARIO: pareciera que en promedio no hay diferencias entre el grupo de tratamiento y 
control */ 
* Paso 5: Reset
drop random

*Test de diferencias en medias
* covariates hace referencia a variable de control o variable independiente
* ver: https://stats.stackexchange.com/questions/409843/what-is-covariate 
foreach covariates of varlist m500_c_11 m500_m_11 incidencia_pobreza_total incidencia_pobreza_extrema gini gasto_pc {
	ttest `covariates', by(treatment_simple) unequal
}

orth_out m500_c_11 m500_m_11 incidencia_pobreza_total incidencia_pobreza_extrema gini gasto_pc, by(treatment_simple) se compare test count
// con este análisis con el orth_out se ve claramente que la única variable que tiene diferencias significativas es gini

*Test de diferencias de distribución
foreach covariates of varlist m500_c_11 m500_m_11 {
	ksmirnov `covariates', by(treatment_simple)
}

* B. USER-WRITTEN COMMANDS
* Opción : aleatorizar
help findit
// la función findit 



 

 				