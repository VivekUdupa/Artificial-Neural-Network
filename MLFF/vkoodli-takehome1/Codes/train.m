function [W,alpha_scale,alpha_shift] = train(a,ep,layers,input,target,dim,y,net,a1_lrn, alpha_scale,alpha_shift,a2_lrn)
    
    dim_bias = dim_bias_calc(dim);
    %dimention weights are taken into account in weight_count function!
    
    %to find the total number of weights
    weight_cnt = 0;
    for i = 1:(layers-1)
        weight_cnt = weight_cnt + (dim(i)*dim(i+1));
    end
    
    
    %initializing weight matrix
    max_weight = weight_count(dim,layers);
   
    %weight matrix W
%     W = 0.1*randn( layers-1, max_weight );
       
    W = 0.01*rand(layers-1, max_weight); %A to D
    
    %code to set unwanted weights to 0
    W = set_zero(dim,W,layers,max_weight);

    %feedforeward and backprop
    pattern = length(target); %number of pattern
    
    %initializing a vector to plot error
    e_plot = zeros(1,ep);
    error_single_plot = zeros(1,ep);
 
    
    si = 1;
    ei = pattern;
    
   
    for i = 1:ep
        
        dw = zeros( layers-1, max_weight );% initialize weight update matrix
        dy = zeros(layers-1, max(dim_bias)); %initialize delta matrix(sensetivity)
        da = zeros(layers-1, max(dim_bias)); %initialize sensitivity for alpha scale
        ds = zeros(layers-1, max(dim_bias)); %initialize sensitivity for alpha shift
        dalpha_scale = zeros(layers-1, max(dim_bias)); %initialize delta(alpha scale) matrix
        dalpha_shift = zeros(layers-1, max(dim_bias)); %initialize delta(alpha shift) matrix
       error_pat = 0;
       error_single_pat = 0;
        for j = 1:pattern
            
            ip = input(:,j); %each pattern of input
            [net,y] =  Feedforeward( ip,dim,layers,W,y,net,alpha_scale,alpha_shift );
            [dw,dalpha_scale,dalpha_shift,error,err_single] = backpropogation( ip,target,dim,layers,W,y,dy,j,dw,a,net,da,alpha_scale,dalpha_scale,ds,alpha_shift,dalpha_shift ); 
            
            %sum of errors of all pattern
            error_pat = error_pat + error;
            error_single_pat = error_single_pat + err_single;
            
            %on-line update
            W = W + a*(dw);
            alpha_scale = alpha_scale + a1_lrn * ( dalpha_scale );
            alpha_shift = alpha_shift + a2_lrn * ( dalpha_shift );

        
        end % pattern   
        %final error for each epoch
        error_plot(1,i) = error_pat;
        error_single_plot(1,i) = error_single_pat;
        
    end % epoch
    
    %plotting error
    X = 1:ep;
    Y = error_plot;
    Z = error_single_plot;
    
    figure
    plot(X,Y,'g','LineWidth',2);
    hold on;
    plot(X,Z,'r','LineWidth',2);
    xlabel("epoch");
    ylabel("Error");
    title("Error Plot");
    legend("E = ((t-o)^2) / 2 ","e = (t - o)");
    
    
    First = [ 'First error = ', num2str(error_plot(1,1)) ];
    Final = [ 'Final error = ', num2str(error_plot(1,end)) ];
    disp(First);
    disp(Final);
    
    

end %function