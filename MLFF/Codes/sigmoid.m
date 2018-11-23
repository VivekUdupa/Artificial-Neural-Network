function y = sigmoid(z,alpha_scale,alpha_shift)
    
    x = alpha_scale * ( z + alpha_shift) ;
    y = 1 / ( 1 + exp(-x) );

end