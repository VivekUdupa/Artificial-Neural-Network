function w(i) = hebbian(num_ss,o,x,y,i)
    %this is the hebbian prescription implementation
    %weight is set to 1 if both units have same sign 
    %weight is set to -1 if units on either side of weight have opposite sign
    if( o(x,i) == o(y,i) )
       w(i) = 1;
    else
       w(i) = -1;
    end
                   
end %function