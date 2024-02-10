#El objetivo de este script es identificar los pulsos en una secuencia de datos. 
#Asumimos que se les ha pasado un filtro para eliminar picos generados por los ruidos
#El funcionamiento es el siguiente:
# 1. Se buscan los m�ximos con la funci�n pulses_max(pulses, threshold, size) Esta funci�n procesa los datos de "pulses" y dice que un punto es un m�ximo si est� por encima de threshold y tiene "size" puntos antes con pendiente positiva o pendiente cero y otros tantos despu�s con pendiente negativa.
# 2. Para cada m�ximo se calcula el comienzo y el final con la funci�n min(Max_points, init,threshold, size). Esta funci�n recibe como par�metro una lista con los m�ximos detectados en la funci�n pulses_max y para cada m�ximo busca el m�nimo a la izq y a la derecha que delimitan el pulso. Un punto es un m�nimo si tiene "size" puntos con pendiente negativa o cero a su izq y con pendiente positiva o cero a su derecha. Tambi�n se considera m�nimo si se ha llegado al threshold 
# 3. Una vez identificado el pulso se integra y se le quita la se�al de background.
#El script necesita dos parámetros:
#entrada: vector de datos a procesar (se supone qu eya filtrados). 
