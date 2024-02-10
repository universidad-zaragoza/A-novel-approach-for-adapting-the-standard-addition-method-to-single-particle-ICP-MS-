#read the raw data, apply a golay_3_5 filter and identify the pulses 
#inputs: 
# raw_data to process (one column)
# noise_threshold uses to detect pulse overlapping: pulses with minimum over the threshold overlap
# max_threshold: used to identify maxima: if a point is below the max_threshold it is not included in the maxima set
# La función devuelve la tabla de frecuencia y una lista con los pulsos detectados y sus características
function [freq_table, pulses_golay_3_5] = golay_3_5(raw_data, noise_threshold, max_threshold);
  pkg load signal;
  pkg load statistics;
  #Golay_3_5: sgolayfilt(x,n,p): Smooth the data in x with a Savitsky-Golay smoothing filter of polynomial order p and length n, n odd, n > p
  golay_3_5_data=sgolayfilt ( raw_data,3,5);
  [pulses_golay_3_5, stats_golay_3_5]=identify_pulses(raw_data, golay_3_5_data, max_threshold, noise_threshold, 1);
  Avg_noise_golay_3_5= stats_golay_3_5(3)/stats_golay_3_5(4); 
  pulses_golay_3_5(:,6)= substract_noise(pulses_golay_3_5, Avg_noise_golay_3_5);
  #Me plantee un ajuste en los pulsos que hacen overlap, pero por ahora no lo aplico
  #pulses_golay_3_5(:,7)= update_overlap(pulses_golay_3_5, raw_data, Avg_noise_golay_3_5);
  freq_table_golay_3_5 = tabulate(pulses_golay_3_5(:,6), 0:1:1800);
  freq_table = freq_table_golay_3_5(:,2);
 end