% function [a,b,c,test,W] = run()
% function [test,W] = run()
function [W,W2,ss,tst,results,test_final] = run()
    %enter epoch
    ep = 200;

    %set a flag to unlearn
    unlearnt = 0; %nothing to unlearn if 0
    
    switch_unlearn = 0; %toggle unlearning ON(1) and OFF(0)
    
    %store dataset path
    [stable,test] = store_path();
    
    disp("No. of stable states");
    %number of stable states
    num_ss = length(stable)
    
    disp("number of test states");
    %number of test states
    num_tst = length(test)
    
    for i = 1: num_ss
        ss(:,i) = read_image(stable(i).name, 'stable/');
    end
    
    for i = 1: num_tst
        tst(:,i) = read_image(test(i).name,'test/');
    end
    
    one_shot = 0; %to select weight update strategy. one shot vs random
    
    %select the unit update mode. 
    unit_update_mode = 1 %'asynchronous';
%     unit_update_mode = 2 %'sequential';
%     unit_update_mode = 3 %'synchronous';
    
    
%     if(one_shot)
    %Finding weights - one shot
        W = Hopfield(ss);
%     else
    %random finding of weights in random order
        [W2,E1] = random(ss,ep);
%     end
   
    %Deepening the energy well
    dig = 1; %switch to turn deepening on and off( 1 is ON)
    how_deep = [3]; %number of times a particular state has to be stored
    deep_states = [5];
    
    if(dig)
        for i = 1: length(deep_states)
            for j = 1:how_deep(i)
                    W = W + Hopfield(ss(:,deep_states(i)));
            end
        end
    end
    
    disp(unit_update_mode);
    if(unit_update_mode == 1) %asynchronous
        %asynchronous unit update
        [test_final,E2,converged] = asynchronous(W,ss,tst,ep);
    elseif(unit_update_mode == 2) %sequential
        %sequential unit update
        [test_final,E2,converged] = sequential(W,ss,tst,ep);
    elseif(unit_update_mode == 3) %synchronous
        %Synchronous update mode. All units are updated simultaneously
        [converged,test_final,E2] = recover(W,tst,ss,ep);
    else
        disp("Select a proper unit update mode");
    end
    
    
    %plotting the energy
    X = 1:length(E2(1,:));
    for i = 1: length( E2(:,1) )
        figure('name','Energy')
        plot(X,E2(i,:),'red','Linewidth',3);
        title("Energy convergence");
        xlabel('Time');
        ylabel('Energy');
    end

    %test_final has the final form of the test states
   
    %convert test_final back to image form.
    results = vec_to_img(test_final);
    
    
    %checking for convergence
   for i=1:length(converged)
        if(converged(i) == 0)
            vec_to_img(tst(:,i));%disp
            disp("Did not converge to stable state,final form:");
            unlearnt = 1; %perform unlearning
            vec_to_img(test_final(:,i)); %disp
        else
            tst(:,i); %disp
            disp("Converged to");
            converged(i)
            ss(:,converged(i)); %disp
        end %if
    end %for
%     
%     %unlearning ************************************************
    if(switch_unlearn)
        for i=1:length(converged)
            if(converged(i) == 0)
                if(unlearnt)
                    W_new = unlearn(W,test_final(:,i));
                end

                count = 1;
                while( unlearnt)
                    count = count + 1
                    if(count > 50)
                        break;
                    end
                %checking if unlearnt
            %     [test_final,E3,converged] = sequential(W_new,ss,tst,ep);
                [test_final,E2,converged] = asynchronous(W_new,ss,tst,ep);

                %unlearning test check
                   for i=1:length(converged)
                    if(converged(i) == 0)
                        vec_to_img(tst(:,i));%disp
                        disp("AFTER UNLEARNING Did not converge to stable state,final form:");
            %             figure('name','unlearnt');
            %             imshow(vec_to_img(test_final(:,i)),'InitialMagnification','fit'); %disp
                          W_new = unlearn(W,test_final(:,i));
                    else
                        tst(:,i); %disp
                        disp("AFTER UNLEARNING  Converged to");
                        converged(i)
                        unlearnt  = 0;
                        figure('name', 'learnt');
                        imshow(vec_to_img(test_final(:,i)),'InitialMagnification','fit'); %disp
                        ss(:,converged(i)); %disp
                    end %if
                end %for

                %unlearnt  test check end
                end %while    
                %store unlearnt result
                results_unlearnt = vec_to_img(test_final);
            end%converged
        end%for i
    end%switch
%unlearning end ********************************************************
 
%displaying the results    
    
  %display the energy of random weight update
      if(~one_shot)
          X = 1:ep;
%           for i = 1:length( ss(1,:) )
%             a = strcat('Energy of stable state ',num2str(i));
%             figure('name',a);
%             plot(X,E1(i,:),'LineWidth',2);
%             xlabel('Epoch');
%             ylabel('Energy');
%           end
            figure('name','net energy');
            plot(X,sum(E1));
            xlabel('Epoch');
            ylabel('Energy');
      end
      
      
    %finding energy of stable states
    for i = 1:num_ss
        engy(1,i) = Energy(ss(:,i),W); 
    end
    figure('name','energy of stable states')
    plot(1:num_ss,engy,'-og','MarkerSize',15,'LineWidth',2);
    title("Energy of stable states");
    xlabel("States");
    ylabel("Energy");
    
    %finding energy of stable states after unlearning
    if(switch_unlearn)
        for i = 1:num_ss
            engy(1,i) = Energy(ss(:,i),W_new); 
        end
        figure('name','energy of stable states after unlearning')
        plot(1:num_ss,engy,'-ro','MarkerSize',15,'MarkerFaceColor','red','LineWidth',2);
        title("Energy of stable states after unlearning");
        xlabel("States");
        ylabel("Energy");
    end%switch
    
%     display stable states
%     for i = 1:num_ss
%         a = strcat('stable state',num2str(i));
%         figure('name',a)
%         imshow(vec_to_img(ss(:,i)),'InitialMagnification','fit');
%     end
%     
%     %display test states
    for i = 1:num_tst
        a = strcat('test state',num2str(i));
        figure('name',a)
        imshow(vec_to_img(tst(:,i)),'InitialMagnification','fit');
    end
%     
%      %display the test results
    for i = 1:num_tst
        a = strcat('result',num2str(i));
        figure('name',a)
        imshow(results(:,:,i),'InitialMagnification','fit');
    end
    
    %display unlearnt result
    if(switch_unlearn)
        for i = 1:num_tst
            a = strcat('result_unlearnt',num2str(i));
            figure('name',a)
            imshow(results_unlearnt(:,:,i),'InitialMagnification','fit');
        end
    end%switch
   
end %function

