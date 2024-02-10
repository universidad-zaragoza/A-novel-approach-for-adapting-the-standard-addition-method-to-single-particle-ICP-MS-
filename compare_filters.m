#read the raw data, performs several filters and compare the results
#inputs: 
# raw_data to process (one column)
# noise_threshold uses to detect pulse overlapping: pulses with minimum over the threshold overlap
# max_threshold: used to identify maxima: if a point is below the max_threshold it is not included in the maxima set
function [filters_comparison,pulses_raw, pulses_avg5, pulses_avg9, pulses_golay_3_5, pulses_golay_3_9] = compare_filters(raw_data, noise_threshold, max_threshold);
  pkg load signal;
  pkg load statistics;
  #raw data
  [pulses_raw, stats_raw]=identify_pulses(raw_data, raw_data, max_threshold, noise_threshold, 1);
  Avg_noise_raw= stats_raw(3)/stats_raw(4); 
  pulses_raw(:,6)= substract_noise(pulses_raw, Avg_noise_raw);
 # pulses_raw(:,7)= update_overlap(pulses_raw, raw_data, Avg_noise_raw);
  freq_table_raw = tabulate(pulses_raw(:,6), 1:1:150);
  filters_comparison(:,1)=freq_table_raw(:,2);
  # Avg5
  avg5_data =  filtfilt (ones (1,5)/5, 1, raw_data);
  [pulses_avg5, stats_avg5]=identify_pulses(raw_data, avg5_data, max_threshold, noise_threshold, 1);
  Avg_noise_avg5= stats_avg5(3)/stats_avg5(4);
  pulses_avg5(:,6)= substract_noise(pulses_avg5, Avg_noise_avg5);
 # pulses_avg5(:,7)= update_overlap(pulses_avg5, raw_data, Avg_noise_avg5);
  freq_table_avg5 = tabulate(pulses_avg5(:,6), 1:1:150);
  filters_comparison(:,2)=freq_table_avg5(:,2);
  # Avg9
  avg9_data =  filtfilt (ones (1,9)/9, 1, raw_data);
  [pulses_avg9, stats_avg9]=identify_pulses(raw_data, avg9_data, max_threshold, noise_threshold, 1);
  Avg_noise_avg9= stats_avg9(3)/stats_avg9(4); 
  pulses_avg9(:,6)= substract_noise(pulses_avg9, Avg_noise_avg9);
  #pulses_avg9(:,7)= update_overlap(pulses_avg9, raw_data, Avg_noise_avg9);
  freq_table_avg9 = tabulate(pulses_avg9(:,6), 1:1:150);
  filters_comparison(:,3)=freq_table_avg9(:,2);
  #Golay_3_5
  golay_3_5_data=sgolayfilt ( raw_data,3,5);
  [pulses_golay_3_5, stats_golay_3_5]=identify_pulses(raw_data, golay_3_5_data, max_threshold, noise_threshold, 1);
  Avg_noise_golay_3_5= stats_golay_3_5(3)/stats_golay_3_5(4); 
  pulses_golay_3_5(:,6)= substract_noise(pulses_golay_3_5, Avg_noise_golay_3_5);
  #pulses_golay_3_5(:,7)= update_overlap(pulses_golay_3_5, raw_data, Avg_noise_golay_3_5);
  freq_table_golay_3_5 = tabulate(pulses_golay_3_5(:,6), 1:1:150);
  filters_comparison(:,4)=freq_table_golay_3_5(:,2);
  #Golay_3_9
  golay_3_9_data=sgolayfilt ( raw_data,3,9);
  [pulses_golay_3_9, stats_golay_3_9]=identify_pulses(raw_data, golay_3_9_data, max_threshold, noise_threshold, 1);
  Avg_noise_golay_3_9= stats_golay_3_9(3)/stats_golay_3_9(4); 
  pulses_golay_3_9(:,6)= substract_noise(pulses_golay_3_9, Avg_noise_golay_3_9);
  #pulses_golay_3_9(:,7)= update_overlap(pulses_golay_3_9, raw_data, Avg_noise_golay_3_9);
  freq_table_golay_3_9 = tabulate(pulses_golay_3_9(:,6), 1:1:150);
  filters_comparison(:,5)=freq_table_golay_3_9(:,2);
 end