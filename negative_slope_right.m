#función negative_slope(pulses, Init, long) 
#Pulses is the data vector; 
#Init, the position to analize
# long: the number of points after Init to analize
function negative = negative_slope_right(pulses, Init, long);
  I=0;
  negative=1;
  while (I < long)
    if (pulses(Init + I) < pulses(Init + I + 1))
      negative=0;
    endif
      I++;
  endwhile
 end;