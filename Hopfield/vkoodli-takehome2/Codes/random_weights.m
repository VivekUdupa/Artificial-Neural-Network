function W = random_weights(num_units)
    %this function generates random weights between [-1 1]
    
    W = randi([0 1],num_units); 
    
    %setting the weight matrix to be [-1 1]
    W = set_matrix(num_units,W);
       

end %function