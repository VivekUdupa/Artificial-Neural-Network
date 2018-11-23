function converged = state_diff(ss,test)
            
%check if there is adifference between stabel states and test state
%i.e. check if the test state converged to any stable state
            
            diff1 = ss - test;
            diff2 = -ss - test; %checking for the inverse of the stable state
            %Now check if any column of diff is all zeros.
            %i.e. next_state converged to that specific stable state in 'o'
            
            
            chk_zro1 = any(diff1); %check if any entry is one
            chk_zro2 = any(diff2);
            
            chk_zro = and(chk_zro1, chk_zro2);
            %chk_zro output will be zero if any element in 1
            
            for j=1:length(chk_zro)
                if(chk_zro(j) == 0)
                    converged = j; %i'th test converged to j'th stable state
                    break;
                else
                    converged = 0;
                end 
                
            end


end %function