#El objetivo de este script es identificar los pulsos en una secuencia de datos. Cuando se detecta un pulso se acumula los valores durante todas su duración generando una entrada con el valor acumulado
#El script necesita dos parámetros:
#entrada: es el .csv a procesar. 
#Nota: he recibido dos formatos de csv distintos: uno con dos columnas (tiempo y pulsos) y otro sólo con los pulsos.
#La entrada se lee en dlmreaddlmread(entrada, ";", [1,1,10,1]), el campo ";" es el separador. Si se usa , habría que poner ","

function salida = compacted_pulses(entrada, umbral)
	
	#leemos la entrada usando como separador ";"
	#data_pulses2 = dlmread(entrada, ";")
	#leemos la segunda columna 
	#second_column=data_pulses2(:,2)
	# la siguiente l�nea es para hacer pruebas desde matrices y no sdesde ficheros csv
	#	second_column=entrada(:,2);
	#la siguiente linea es para cuando solo hayuna columna
	second_column=entrada;
	# identificamos los valores mayores que 0
	index = find(second_column > 0);
	non_zero_elements = size(index,1);
	#indice para el bucle
	i=1;
	#indice para la salida
	j=0;
	while (i <= non_zero_elements)
		#fila nos indica dónde empieza el pulso
		fila_inicial=index(i);
		fila_actual= fila_inicial;
		#actualizamos las variables con el primer valor del pulso
		anchura_pulso=1;
		acumulador=second_column(fila_inicial);
		j=j+1;
		i=i+1;
		end_pulse=0;
		while (i <= (non_zero_elements))&(end_pulse == 0)
			# si quedan elementos por procesar
			fila_siguiente=index(i);
			#si son filas consecutivas pertenecen al mismo pulso
			if (fila_siguiente == (fila_actual +1));
				anchura_pulso=anchura_pulso+1;
				acumulador=acumulador+second_column(fila_siguiente);
				fila_actual=fila_siguiente;
				i=i+1;
			else
				end_pulse=1;
			end
			
		endwhile;
		salida(j,1)= fila_inicial;
		salida(j,2)=acumulador;
		salida(j,3)=anchura_pulso;
	endwhile;
	#calculamos la tabla de frecuencias
	pkg load statistics;
	second_column=salida(:,2);
	freq_table = tabulate(second_column, 1:1:501);
	csvwrite('freq_table.csv', freq_table);
	
			
		
		

	
	
	