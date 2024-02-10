#función pulses_min(pulses, threshold, slope_size) 
#Esta función procesa los datos de "pulses"
#Un punto es un mínimo si se cumple alguna de estas dos condiciones: 
# 1) su valor es menor o igual al threshold 
# 2) tiene "slope_size" puntos antes con pendiente negativa o pendiente cero y otros tantos después con pendiente positiva.
function minimum = pulses_min(pulses, threshold, slope_size);
   data_size=size(pulses)(2);#datos a procesar
   minimum = zeros(1,data_size);
   start=slope_size+1;
   end_for=data_size-slope_size;
   for i=start:end_for
     if (pulses(i) <= threshold)
        minimum(i)=1;
     else
       pos_slope=positive_slope_right(pulses, i, slope_size);
       neg_slope=negative_slope_left(pulses, i, slope_size);
       if ((pos_slope == 1)&&(neg_slope == 1))
         minimum(i)=1;
       endif
     endif
    endfor
    
end