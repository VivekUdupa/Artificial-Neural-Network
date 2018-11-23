function [z,y] =  neuron(ws,ips,alpha_scale,alpha_shift)
    
    z = ws * ips;
    y = sigmoid(z,alpha_scale,alpha_shift);
  
end