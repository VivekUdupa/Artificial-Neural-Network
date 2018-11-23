function [test_final,E2,converged] = asynchronous(W,ss,tst,ep)

    num_ss = length( ss(1,:) ); %number of stable states
    num_unit = length( ss(:,1)); %number of units
    
    num_tst = length( tst(1,:) ); %number of test states
    converged = zeros(1,num_tst); %initialization 
    for t = 1:num_tst %perform for all test states
        prev_state = tst(:,t);
        next_state = tst(:,t);
        %generate a random order in which the network will update units
%         order = randperm( num_unit );
            
        for i = 1:ep %execute epoch number of times
            %generate a random order in which the network will update units
            order = randperm( num_unit );
%             %show image evolution at each itiration
%             figure('name','evolution_async')
%             imshow(vec_to_img(next_state),'InitialMagnification','fit');
%             a = strcat('evol_async',num2str(i));
%             saveas(gcf,a);
            
            for o = 1:num_unit
                    %display fig
                    %show image evolution at each itiration
%                     figure('name','evolution_async')
%                     imshow(vec_to_img(next_state),'InitialMagnification','fit');
%                     a = strcat('evol_async',num2str((num_unit*i + o)));
%                     saveas(gcf,a,'jpeg');
%                     close;
                    %end
                               
                    unt = order(o); %selct the unit to update from order
                    next_state(unt,1) = W(unt,:) * prev_state ;
                    next_state(unt,1) = sign_corr( next_state(unt,1), prev_state(unt,1));
                    prev_state = next_state; 
                    
                    %calculate energy at each step
                    E2(t,(num_unit*i + o)) = Energy(next_state,W);
                    
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