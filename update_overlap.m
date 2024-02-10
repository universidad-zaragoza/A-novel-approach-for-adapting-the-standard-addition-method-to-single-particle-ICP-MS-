#When two pulses overlap the minimum between them contributes two both pulses(half for each)
function pulses_overlap= update_overlap(pulses, Raw_data, Avg_noise);
  number_of_pulses=size(pulses,1);#datos a procesar
  for i=1:number_of_pulses
    #first we check the left end of the pulse
    pulses_overlap(i)=pulses(i,3);#pulses(i,3) is the integration of the data from the pulse
    if (pulses(i,4)=1)  #pulses(i,4)=1 identifies an overlap in the left end
      left_end=pulses(i,1)-1;#pulses(i,1)= start of the pulse
      pulses_overlap(i)=  pulses_overlap(i)+(Raw_data(left_end)/2)- Avg_noise/2; 
    endif;
    if (pulses(i,5)=1)  #pulses(i,5)=1 identifies an overlap in the right end
      right_end=pulses(i,1) + pulses(i,2); #pulses(i,2)= pulse width
      pulses_overlap(i)=  pulses_overlap(i)+(Raw_data(right_end)/2)- Avg_noise/2; 
    endif;
    #second the right end 
  endfor  
end