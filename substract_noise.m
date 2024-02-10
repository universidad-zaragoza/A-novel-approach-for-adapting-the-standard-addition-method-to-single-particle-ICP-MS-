#substract_noise receive the information of the found pulses and the average noise identified in the signal
#for each pulse the function applies this formula: New_integrated_value= integrated_value - Avg_noise*pulse_width 
function pulses_without_noise= substract_noise(pulses, Avg_noise);
  number_of_pulses=size(pulses,1);#datos a procesar
  for i=1:number_of_pulses
    pulses_without_noise(i)=pulses(i,3)- Avg_noise*pulses(i,2);
  endfor  
end