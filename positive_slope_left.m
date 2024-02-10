#función positive(pulses, Init, long) 
#Pulses is the data vector; 
#Init, the position to analize
# long: the number of points before Init to analize
function positive = positive_slope_left(pulses, Init, long);
  I=0;
  positive=1;
  while (I < long)
    if (pulses(Init - I) < pulses(Init - I -1))
      positive=0;
    endif
  #  positive=positive+pulses(Init -I)
    I++;
  endwhile
 end;