#El objetivo de este script es identificar los pulsos en una secuencia de datos. 
#Asumimos que se les ha pasado un filtro para eliminar picos generados por los ruidos
#El funcionamiento es el siguiente:
# 1. Se buscan los máximos con la función pulses_max(pulses, threshold, size) Esta función procesa los datos de "pulses" y dice que un punto es un máximo si está por encima de threshold y tiene "size" puntos antes con pendiente positiva o pendiente cero y otros tantos después con pendiente negativa.
# 2. Para cada máximo se calcula el comienzo y el final con la función min(Max_points, init,threshold, size). Esta función recibe como parámetro una lista con los máximos detectados en la función pulses_max y para cada máximo busca el mínimo a la izq y a la derecha que delimitan el pulso. Un punto es un mínimo si tiene "size" puntos con pendiente negativa o cero a su izq y con pendiente positiva o cero a su derecha. También se considera mínimo si se ha llegado al threshold 
# 3. Una vez identificado el pulso se integra y se le quita la señal de background.
#El script necesita dos parÃ¡metros:
#entrada: vector de datos a procesar (se supone qu eya filtrados). 
