function W = set_matrix(num_units,W)
  %This function sets the matrix values to [-1 1] and makes the diagonal
  %elements zero

    for k = 1: num_units
       for l = 1:num_units
           if(k == l) %diagonal elements
               W(k,l) = 0;
           elseif( W(k,l) == 0 ) %if zero set to -1
               W(k,l) = -1;
           end
       end
    end

end %function