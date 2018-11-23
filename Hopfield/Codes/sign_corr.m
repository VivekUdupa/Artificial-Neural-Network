function next_state = sign_corr(next_state, prev_state);
    
    for i = 1:length(next_state(:,1))
        if( next_state(i,1) > 0)
            next_state(i,1) = 1;
        elseif(next_state(i,1) < 0)
            next_state(i,1) = -1;
        elseif( next_state(i,1) == 0)
            next_state(i,1) = prev_state(i,1);
        end
    end
                

end