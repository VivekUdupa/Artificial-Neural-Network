function w = hebbian(num_ss,o,x,y,i)
    %this is the hebbian prescription implementation
    %weight is set to 1 if both units have same sign 
    %weight is set to -1 if units on either side of weight have opposite sign
    if( o(x,i) == o(y,i) )
       w = 1;
    else
       w = -1;
    end
                   
end %function