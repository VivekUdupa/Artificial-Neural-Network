function max_weight = weight_count(dim,layers)

    neuron_count = sum(dim); %total number of neurons
    
    %to find the layer with max weights
    
    sup_dia_mat = dim' * dim; %outer product of dim
    for i = 1:layers-1
        %sup_dia has the super diagonal elements
        sup_dia(i) = ( sup_dia_mat(i , i+1 )); 
    end
    
    %max weight has the maximum weight count in the network
    %+max(dim) is for the addition of weights from the bias
    
    max_weight = max(sup_dia + dim(2:end) );

end    