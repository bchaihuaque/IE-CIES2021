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
cls
clear all

*===============================================================================
* 						I. CONFIGURACIÓN INICIAL
*===============================================================================

***1.1 setting user's path (absolutos)
	if ("`c(username)'" == "bchai") {
		global	proyecto	"D:\Estudiando\Impact-Evaluation\IECIES2021"
		}

	if ("`c(username)'" == "bchaihuaque") {
		global 	proyecto 	"/home/bchaihuaque/Estudiando/Impact-Evaluation/IECIES2021"
		}
	
***1.2 setting folder structure (dinámicos)

		global	codes		"${proyecto}/codes"
		global	data		"${proyecto}/data"
		global	outputs		"${proyecto}/outputs"
		
		// sesión práctica 1
		global 	codes_1_1	"${codes}/01_aleatorizacion"
		global	data_1_1	"${data}/01_educacion_loreto"
	
***1.3 install required packages

		local packages	ietoolkit iefieldkit winsor estout outreg2 asdoc xml_tab outwrite reghdfe ftools

		foreach pkgs in `packages' {
			capture which `pkgs'
			if (_rc != 111) {
				display as text in smcl "paquete {it: `pkgs'} está instalado"
			}
			else {
				display as error in smcl `"paquete {it: `pkgs'} necesita instalarse."'
				capture ssc install `pkgs', replace
				if (_rc == 601) {
					display as error in smcl `"El paquete `pkgs' no se encuentra en SSC;"' _newline ///
					`"Por favor, verifique si {it: `pkgs'} está escrito correctamente y si `pkgs' es en efecto un comando. "'
				}
				else {
					display as result in smcl `"El paquete `pkgs' ha sido instalado."'
				}
			}
		}
	ieboilstart, version(14.0)

***1.4 Setting up execution
		global primera_semana 	0
		global segunda_semana 	0
		global tercera_semana	0
		global cuarta_semana	0

*===============================================================================
* 						II. EJECUCIÓN DE DO-FILES
*===============================================================================	

		if (${primera_semana} == 1) {
			do "${codes_1_1}/asignacion-aleatoria.do"
		}
	