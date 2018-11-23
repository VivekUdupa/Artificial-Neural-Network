function [dw,dalpha_scale,dalpha_shift,error,err_single] = backpropogation(ip,target,dim,layers,W,y,dy,j,dw,a,net,da,alpha_scale,dalpha_scale,ds,alpha_shift,dalpha_shift)
    
    dim_bias = dim_bias_calc(dim); %dim with bias units
    
    for i = layers:-1:2
        
        cur_cnt = dim(i); %neurons count in current layer without bias
        
        if(i ~= layers) %there is no next layer for output layer
            %bias is not considered as neuron,thus dim_bias(i+1) not
            %used here
            nxt_cnt = dim(i+1); %neuron count in previous layer
        end
        %starting and ending indiecs
            si = 1;
            ei = cur_cnt; %current count without bias
            eib = dim_bias(i); %current count with bias
            %no bias in final layer. thus neuron count doesnt include bias
            if( i == layers)
                eib = ei;
            end
            
        %%calculating dy(sensitivity)
        for m = 1:eib %current layer
            
            %sigmoid derivative wrt W and alpha respectively
            %fnet are single values.
            fnet = alpha_scale(i-1,m) * ( y(i-1,m) * (1 - y(i-1,m)) );
%              fnet_delta = ( y(i-1,m) * (1 - y(i-1,m)) );
            
            if( i == layers ) %output layer
                
                %output layer
                err = target(j,m) - y(i-1,m); %single value
                
                %for plotting error ( sum of errors of all o/p neurons)
                if( m == 1)
                    error = (err*err)/2;
                    err_single = err;
                else
                    error = error + (err*err)/2;
                    err_single = err_single + err;
                end
                
                %sensitivity for weights updation
                dy(i-1,m) = fnet * err; %normal single value multiplication
                
                %da = sensitivity for alpha1(scaling)
                da(i-1,m) = fnet * err;
                
                %da = sensitivity for alpha2(shifting)
                ds(i-1,m) = fnet * err;
                
            else %hidden layers
                
                si = m;
                for k = 1:nxt_cnt
                    Wseg(:,k) = W(i,si);
                    si = si + eib;
                end %k for
                
                %weight sensitivity
                %inner product of all next layersensitivity with weights
                %connecting them to current neuron
                err_hidden  = Wseg * dy(i,1:nxt_cnt)' ;
                dy(i-1,m) = fnet * err_hidden ; 
                
                %no need of delta function. this is just direct
                %multiplication of fnet and err_hidden
                
                %same procedure as above
                %alpha1(scaling) calcuations
                err_hidden  = Wseg * da(i,1:nxt_cnt)' ;
                da(i-1,m) = fnet * err_hidden ;
                
                %alpha2(shifting) calcuations
                err_hidden  = Wseg * ds(i,1:nxt_cnt)' ;
                ds(i-1,m) = fnet * err_hidden ;

            end %if
        end %m for
    end% i for
    
    %%calculating dw and dalpha
    for i = 1:layers-1
        cur_cnt = dim_bias(i);%to select input/previous neuron output
        nxt_cnt = dim(i+1); %bias in not considered as a neuron. 
        si = 1;
        ei = cur_cnt;
        for m = 1:nxt_cnt %m = 1 points at y11
            if( i == 1)
                opt = ip; %input layer
            else
                %all outputs of hidden layer/inputs to next layer
                opt = y(i-1,1:cur_cnt);
            end %if end
            
            dyseg = dy(i,m); %individual neurons in next layer

            %weight delta matrix
            
            %no need of weight_corr(dyseg,opt) function below.
            %direct multiplication is sufficient
            dw(i,si:ei) = opt * dyseg;  

            %alpha1(scaling) delta matrix
            mul_factor = ( ( net(i,m) + alpha_shift(i,m) ) / alpha_scale(i,m) );
            dalpha_scale(i,m) = da(i,m) * mul_factor ;
            
            %alpha2(shifting) delta matrix
            dalpha_shift(i,m) = ds(i,m);

            
            %update starting and ending index
            si = si+cur_cnt;
            ei = ei+cur_cnt;

        end %m loop
    end %i loop
    
end %function