#El objetivo de este script es aplicar un filtro de suavizado sobre los raw data
#El script necesita como parametro el .csv a procesar
#Nota: he recibido dos formatos de csv distintos: uno con dos columnas (tiempo y pulsos) y otro sólo con los pulsos.
#La entrada se lee en dlmreaddlmread(entrada, ";"), el campo ";" es el separador. Si se usa , habría que poner ","

function salida = smooth(entrada)
	
	pkg load signal;
  #leemos la entrada usando como separador ";"
	raw_data = dlmread(entrada, ";");
	#leemos la segunda columna 
	second_column=raw_data(:,2);
	# la siguiente l�nea es para hacer pruebas desde matrices y no sdesde ficheros csv
	#	second_column=entrada(:,2);
	#la siguiente linea es para cuando solo hayuna columna
	# second_column=entrada;
	# identificamos los valores mayores que 0
	#Prueba devolvemos la diferencia ebtre los datos originales y los nuevos
  salida = sgolayfilt (second_column, 3, 11);
  
	
			
		
		

	
	
	