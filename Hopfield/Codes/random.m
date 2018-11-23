function [W,E] = random(o,ep)


    %stable state is represented by the variable o
    
   num_units = length( o(:,1) ); 
   num_ss = length(o(1,:)); %number of stable states
   
   %initial random weights
   W = zeros(num_units,num_units);
   
   for p = 1: ep
       %selecting numbers < threshold
       nu_sel = rand(num_units,num_units);
       thres = 0.1;

       for x = 1:num_units %check all units
           for y = 1:num_units
               if(x == y)
                   continue;
               elseif(nu_sel(x,y) > thres)
                   continue;%skip if number is > threshold
               end
               %if number < threshold then go execute the following
               %% calculating the individual weight matrices for each stable state
               for i = 1:num_ss
%                    w(i) = hebbian(num_ss,o,x,y,i);
                    w(i) = o(x,i)*o(y,i);
               end %for i
               W(x,y) = sum(w);
               W(y,x) = W(x,y); %symmetric
               end %for y
       end %for x
       %calculate the energy
       for i = 1:num_ss
           E(i,p) = Energy(o(:,i),W);
       end
   end %for p/epoch
end %function