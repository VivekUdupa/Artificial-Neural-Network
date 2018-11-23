function [test_final,E3,converged] = sequential(W,ss,tst,ep)
%This function performs sequential update of test images to check if they
%converge into any stable states

    num_ss = length( ss(1,:) ); %number of stable states
    num_unit = length( ss(:,1)); %number of units
    
    num_tst = length( tst(1,:) ); %number of test states
    converged = zeros(1,num_tst); %initialization 

    for t = 1:num_tst %perform for all test states
        prev_state = tst(:,t);
        next_state = tst(:,t);
        for i = 1:ep %execute epoch number of times
                       
            %show image evolution at each itiration
%             figure('name','evolution_sequential')
%             imshow(vec_to_img(next_state),'InitialMagnification','fit');
            
            for o = 1:num_unit
                    
                    next_state(o,1) = W(o,:) * prev_state ;
                    next_state(o,1) = sign_corr( next_state(o,1), prev_state(o,1));
                    prev_state = next_state; 
                    
                    %calculate energy at each step
                    E3(t,(num_unit*i + o)) = Energy(next_state,W);
                    
            end %o
            
            %check for convergence into stable state
            converged(t) = state_diff(ss,next_state);
            %if the test state reaches a stable state then stop
            if(converged(t) ~= 0)
                break;
            end
            
            
           
        end% epoch
        test_final(:,t) = next_state; 
    end %for t

end %function