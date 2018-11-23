%sets unwanted weight elements to zero
function W = set_zero(dim,W,layers,max_weight)

    for x = 1:layers-1
           
        cur_cnt = dim(x)+1; %neurons in current layer ( +1 bias)
        
        %( no need of connecting previous bias to this bias, thus no +1 in nxt_cnt)
        nxt_cnt = dim(x+1); %neurons in next layer 
               
        limit = cur_cnt * nxt_cnt; %max weights needed to link curent to next layer
        
        W(x,limit+1:max_weight) = 0; %excess weights set to zero
    
    end
end