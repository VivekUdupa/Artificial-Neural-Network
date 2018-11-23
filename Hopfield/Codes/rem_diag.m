function W = rem_diag(W)
%sets W(i,i) to zero. i.e. diagonal elements are set to zero.
   
    for i = 1:length(W(:,1))
        for j = 1:length(W(1,:))
            if( i == j)
                W(i,j) = 0;
            end
        end %for j
    end %for i
   W; 
end %function