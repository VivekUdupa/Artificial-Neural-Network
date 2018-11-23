function W_new = unlearn(W,sp_state)
%This function will change the weight matrix by subtracting the weight
%matrix of the spurious state.

    a = 0.5 % learning rate
     W_new = W - a*(sp_state' .* sp_state); %subtracting the spurious state weights
%     

end %function