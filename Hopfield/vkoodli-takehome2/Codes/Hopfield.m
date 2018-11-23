function W = Hopfield(o)

    num_ss = length( o(1,:) ); %number os stable states

    %storing individual states
    w = store(num_ss,o);
    
    %Computing the Combined weight matrix
    W = combine(num_ss,w);
    
    %Removing the diagonal elements
    W = rem_diag(W);
    
    
    
end