#funci�n pulses_find_min_right(init, pulses, slope_size) 
#Esta funci�n procesa los datos de "pulses" buscando hacia la izquierda a partir de la posici�n de init
#Un punto es un m�nimo si se cumple alguna de estas dos condiciones: 
# 1) su valor es menor que el threshold del ruido
# 2) tiene "slope_size" puntos antes con pendiente negativa o pendiente cero y otros tantos despu�s con pendiente positiva.
# Si no se encuentra ning�n m�nimo se devuelve la primera posici�n
function minimum = pulses_find_min_right(init,pulses, slope_size, noise_threshold);
   i=init;
   last_value=size(pulses,1);#datos a procesar
   found=0;
   while found==0
     #disp(i);#for debugging
     if (i>last_value) #nunca deber�a ser menor que 1 pero por si acaso
        found=1;
        disp('error: indice fuera de rango');
     elseif (pulses(i) < noise_threshold )
        found=1;
     elseif (i==last_value) #se ha llegado al final
        found=1;   
     elseif (i<=(last_value-slope_size)) #si es mayor no se puede encontrar un m�nimo
       pos_slope=positive_slope_right(pulses, i, slope_size);
       neg_slope=negative_slope_left(pulses, i, slope_size);
       if ((pos_slope == 1)&&(neg_slope == 1))
        found=1;
       else
        i=i+1;
       endif
     else
       i=i+1;
     endif
    endwhile
    minimum=i;
end