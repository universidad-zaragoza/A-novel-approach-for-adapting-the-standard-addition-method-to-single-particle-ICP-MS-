#función pulses_max(pulses, threshold, slope_size) 
#Esta función procesa los datos de "pulses"
#Un punto es un máximo si: 
# 1) está por encima de threshold 
# 2) tiene "slope_size" puntos antes con pendiente positiva o pendiente cero y otros tantos después con pendiente negativa.
function maxima = pulses_max(pulses, threshold, slope_size);
   data_size=size(pulses,1);#datos a procesar
   start=slope_size+1;
   end_for=data_size-slope_size;
   found=0;
   for i=start:end_for
     if (pulses(i)> threshold)
       pos_slope=positive_slope_left(pulses, i, slope_size);
       neg_slope=negative_slope_right(pulses, i, slope_size);
       if ((pos_slope == 1)&&(neg_slope == 1))
         found++;
         maxima(found)=i;
       endif
     endif
   endfor
end
