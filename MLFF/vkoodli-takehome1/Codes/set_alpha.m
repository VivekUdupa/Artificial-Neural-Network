function alpha = set_alpha( alpha, layers, dim_bias );
    
     %index from where elements should be set to zero
    %dim_bias(2) represents first alpha layer. Because input layer has no
    %alpha element. 
    for i = 1:layers-1
        si = dim_bias(i+1) + 1;
        alpha(i,si:end) = 0;
    end

end %function