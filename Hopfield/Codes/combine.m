function W = combine(num_ss,w)
    %finding the sum of all individual stored states i.e. (small) w
     W = 0;
    for i = 1:num_ss
        W = W + w(:,:,i);
    end
end