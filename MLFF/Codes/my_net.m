function [ W ,output, alpha_scale,alpha_shift ] = my_net(a,ep,mode,layers,input,target,dim,opt,a1_lrn,a2_lrn)
% function [a,ep,mode,layers,input,target,dim,opt] = my_net(a,ep,mode,layers,input,target,dim,opt)

    %calculate dimention with bias
    dim_bias = dim_bias_calc(dim);
    
    %flag to determine if the network is trained or not
    train_complete = 0;
    
    %initializing y to 1 with bias dimentions because bias has standard 1 value 
    y = ones(layers-1,max(dim_bias)); %initialize output matrix
    
    net = zeros(layers-1,max(dim)+1); %initialize net matrix
    
    %alpha1 used for scaling
    alpha_scale = 1.4 + 0.4*rand(layers-1,max(dim_bias)); %initialize alpha matrix
%     alpha_scale = 1 + 0*rand(layers-1,max(dim_bias)); %initialize alpha matrix

    %alpha2 used for shiftng
    alpha_shift = 1.4 + 0.4*rand(layers-1,max(dim_bias)); %initialize alpha matrix
%     alpha_shift = 1 + 0*rand(layers-1,max(dim_bias));
    
    %set unwanted alpha to zero
    alpha_scale = set_alpha(alpha_scale,layers,dim_bias);
    alpha_shift = set_alpha(alpha_shift,layers,dim_bias);


    if(mode == 'train' )
        [ W, alpha_scale, alpha_shift ] = train( a, ep, layers, input, target, dim, y, net, a1_lrn, alpha_scale, alpha_shift, a2_lrn );
%         disp('end of training');
        train_complete = 1;
    end
    
    if( opt == 1)
        if( train_complete)
            %disp('output mode');
            for i = 1:length(input)
                ip = input(:,i);
                [net,y] = Feedforeward(ip,dim,layers,W,y,net,alpha_scale,alpha_shift);
               
                %elements to be displayed after execution
                %output layer y represents the required output.
                si = layers - 1;
                ei = length(target(1,:));
                output(:,i) = y(si,1:ei); %final layer output
                w = W; %final weights
            end

        else
                disp("Network not trained!");
        end

    else
        disp("set 'opt' to 1");
    end
     
end
    

