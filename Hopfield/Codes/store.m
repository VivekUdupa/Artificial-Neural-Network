function w = store(num_ss,o)
   %finding the outer product of each state given and storing them in small
   %w matrix. 
   %Sum of all w matrices will give the final weight W.
    
    for i = 1:num_ss
        w(:,:,i) = o(:,i) .* o(:,i)';
    end
end