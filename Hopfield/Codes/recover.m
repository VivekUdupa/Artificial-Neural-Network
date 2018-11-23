function [converged,test_final,E] = recover(W,test,o,epoch)
   
    x = length( test(1,:) ); %number of test entries
    converged = zeros(1,x);
    for i=1:x   %execute for each test data 
        %converged vector holds value 1 in i'th column if i'th test 
        %data converges to any of the stable state
        
        count = 1; %represents the number of executin taken to converge
        prev_state = test(:,i); 
        while( count <= epoch ) %perform epoch number of times
            
            %Calculate the energy
            E(i,count) = -0.5 * prev_state' * W * prev_state;
%             figure(count+1000000)
%             imshow(vec_to_img(prev_state) );
            
            %calculate the next state
            next_state = W*prev_state;
            next_state = sign_corr(next_state,prev_state);

            %check if the next state converges to any stable state
            converged(i) = state_diff(o,next_state);
                       
            
            count = count + 1;
            prev_state = next_state;
             
            %break the while loop if the test state converged to any stable
            %state
            if(converged(i) ~= 0)
                break;
            end
            

        end %while
        test_final(:,i) = prev_state;
        E(i,count) = -0.5 * prev_state' * W * prev_state;
    end %for
end