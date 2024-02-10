#función identify_pulses(raw_data, filtered_data, max_threshold, noise_threshold, slope_size) 
#Esta función procesa los datos de "filtered_data"  e identifica los pulsos, despue´s utiliza los "raw_data para calcular la integral del pulso"
#Para cada pulso proporciona la siguiente información:
#start: punto en el que comienza
#width: anchura del pulso
#integration: valor acumulado del pulso
#overlap: indica si este pulso se solapa con otros o nonzeros
# Para definir qué es un pulso se usan los valores de entrada
# Primero se identifican los máximos. Un punto es un máximo si: 
# 1) está por encima de max_threshold
# 2) tiene "slope_size" puntos antes con pendiente positiva o pendiente cero y otros tantos después con pendiente negativa.
# Despues se buscan los mínimos anteriores y posteriores a cada máximo. Y el intervalo entre ambos es el pulso
# Si los mínimos están por debajo del noise_threshold se entiende que es pulso aislado, si los mínimos son mayores es que se solapa con otros pulsos
# Al acabar de procesar el raw data proporciona la siguiente información:
# 1) pulses_list que es la lista con los pulsos
# 2) statistics que devuelve datos generales: número de pulsos, valor medio, valores medios de los datos que no son pulsos
# Known issues: for functions with a flat regions, some values of the pulses can be lost
# Example:  1   2   3   4   5   6   6   6   6   6   7   7   7   8   7   6   5   4   4   3   4   5   6   6   6   6   5   5   4   3   1
# in that function the first pulse goes from 1 to 8, and the next one goes from 10 to 20. Value 9 is out of both pulses
#Duda ¿qué hago con el mínimo entre dos pulsos que se solapan? Ahora mismo el mínimo queda fuera del pulso. Una opción sería sumar medio mínimo a cada uno

function [pulses_list, statistics] = identify_pulses(raw_data, filtered_data, max_threshold, noise_threshold, slope_size);
   maxima=pulses_max(filtered_data, max_threshold, slope_size);
   previous_end=1; #this is used to prevent that two pulses uses the same data
   number_of_max=size(maxima,2);#datos a procesar
   ##disp(number_of_max);
   processed_max=0;
   noise_index=1;
   noise_data=0; #used to count the data out of the pulses
   noise_sum=0;# sum of all the data out of the pulses
   pulses_data=0;#number of meassures tagged as pulses
   for i=1:number_of_max
     current_max=maxima(i);
     if (current_max > previous_end)
      start_pulse=pulses_find_min_left(current_max, filtered_data, slope_size, noise_threshold) + 1;
      end_pulse=pulses_find_min_right(current_max, filtered_data, slope_size, noise_threshold) - 1;
      #disp("start_pulse");
      #disp(start_pulse);
      #disp("end_pulse");
      #disp(end_pulse);
      width=end_pulse - start_pulse +1;
      processed_max++;
      integration=sum(raw_data(start_pulse:end_pulse));
      pulses_list(processed_max,1)=start_pulse;
      pulses_list(processed_max,2)=width;
      pulses_list(processed_max,3)=integration;
      pulses_data+=width;
      if(filtered_data(start_pulse-1) <= noise_threshold)
        pulses_list(processed_max,4)=0; #No overlap at the left end
      else
         pulses_list(processed_max,4)=1; #Overlap at the left end
      endif  
      if(filtered_data(end_pulse+1) <= noise_threshold)
        pulses_list(processed_max,5)=0; #No overlap at the right end
      else
         pulses_list(processed_max,5)=1; #Overlap at the right end
      endif  
      #llevamos la cuenta del ruido
      if (start_pulse > noise_index) #si el final del pulso anterior no se solapa con el principio de este todo lo que haya por el medio es ruido
        noise_sum+=sum(raw_data(noise_index:(start_pulse-1))); #sumamos el intervalo desde el final del último pulso hasta el comienzo nuevo
        noise_data=noise_data + start_pulse - noise_index;# sumamos el número de elementos que hemos saltado de un pulso a otro
      endif 
      noise_index= end_pulse + 1;#situamos el índice al final del nuevo
     endif
    previous_end=end_pulse;
    #disp(noise_index);
    #disp('noise_data: ');
    #disp(noise_data);
    #disp('pulses_data: ');
    #disp(pulses_data);
   endfor
   noise_data=noise_data + size(raw_data,1)- noise_index +1; #sumamos al ruido los datos que van desde el último pulso hasta el final
   #disp('noise_data: ');
   #disp(noise_data);
   noise_sum+=sum(raw_data(noise_index:size(raw_data,1))); 
   statistics(1)= processed_max;#number of maxima
   statistics(2)=mean(raw_data);#valor medio del raw_data
   statistics(3)=noise_sum;#acumulado del ruido
   statistics(4)=noise_data;#number of data tagged as noise
   statistics(5)=pulses_data; #number of data tagged as pulses
   
 end