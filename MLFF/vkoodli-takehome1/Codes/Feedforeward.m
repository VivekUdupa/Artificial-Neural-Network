function [net,y] = Feedforeward( input,dim,layers,W,y,net,alpha_scale,alpha_shift)

    

    for i=1:layers-1
        
        %input neurons
        cur_cnt = dim(i)+1; %neurons in current layer +1 bias
        
        %output neurons
        nxt_cnt = dim(i+1); %neurons in next layer
        
        %to section out weight matrix
        si = 1; %starting index
        ei = cur_cnt;   %ending index 
               
        for m = 1:nxt_cnt

            %weight segment selection
            ws = W(i, si:ei); 

            %input segment selection
            if(i == 1)
                ips = input;
            else
                ips = y(i-1, 1:cur_cnt)'; 
            end

            %selecting alpha
            alpha_scale_i = alpha_scale(i,m); %selecting corrosponding alpha_scale
            alpha_shift_i = alpha_shift(i,m); %selecting corrosponding alpha_shift

            
            %calculate output and net activation
            [ net(i,m) , y(i,m) ] = neuron(ws,ips,alpha_scale_i,alpha_shift_i);

            %slide indices to select next set of weights
            si = si + cur_cnt;
            ei = ei + cur_cnt;

        end % m forloop
    end %i forloop end
    
    
    
end %function end