function z = dim_bias_calc(dim)

%function to calculate dim vector with bias.
%all layers except output layer will get one extra unit. i.e bias unit.
%bias unit is connected to all normal units in next layer.
%bias unit has no input. 


    %total length of dim vector i.e # of layers
    x = length(dim); 
    
    %output layer has no bias neuron. thus y gives the # of layers with bias
    y = x - 1; 
    
    %create a vector with 1's for all layers except last layer. 
    add_vec = [ ones(1,y),zeros(1,(x-y)) ];
    
    %add 1 to all layer except last layer
    z = dim + add_vec ;

end