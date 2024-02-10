#función pulses_find_min_left(init, pulses, slope_size) 
#Esta función procesa los datos de "pulses" buscando hacia la izquierda a partir de la posición de init
#Un punto es un mínimo si se cumple alguna de estas dos condiciones: 
# 1) su valor es menor que el threshold del ruido
# 2) tiene "slope_size" puntos antes con pendiente negativa o pendiente cero y otros tantos después con pendiente positiva.
# Si no se encuentra ningún mínimo se devuelve la primera posición
function minimum = pulses_find_min_left(init,pulses, slope_size, noise_threshold);
   i=init;
   found=0;
   while found==0
     #disp(i);#for debugging
     if (i<1) #nunca debería ser menor que 1 pero por si acaso
        found=1;
        disp('error: indice menor que 1');
     elseif (pulses(i) < noise_threshold )
        found=1;
     elseif (i==1) #se ha llegado al final
        found=1;   
     elseif (i > slope_size) #si es menor no se puede encontrar un mínimo
       pos_slope=positive_slope_right(pulses, i, slope_size);
       #disp(pos_slope);
       neg_slope=negative_slope_left(pulses, i, slope_size);
       #disp(neg_slope);
       if ((pos_slope == 1)&&(neg_slope == 1))
        found=1;
       else
        i=i-1;
       endif
     else
       i=i-1;
     endif
    endwhile
    minimum=i;
end