o1 = [ 1; 1; 1; 1];
o2 = [ -1; -1; -1; -1];
o3 = [ 1; -1; 1; -1];
o4 = [-1; 1; -1; 1];

% o_1 = [o1 o2];
% o_2 = [o3 o4];

% o1 = [ 1 0 0 0 0;
%        1 0 0 0 0;
%        1 0 0 0 0;
%        1 0 0 0 0;
%        1 1 1 1 1];
%    
% o2 = [1 0 0 0 1
%       1 0 0 0 1
%       1 1 1 1 1
%       1 0 0 0 1
%       1 0 0 0 1];
  

       

w1 = o1 .* o1';
w2 = o2 .* o2';
w3 = o3 .* o3';
w4 = o4 .* o4';

w = w1 + w2 +w3;
for i = 1:4
    for j = 1:4
        if (i == j)
            w(i,j) = 0;
        end
    end
end

w

o4 = [ 1 0 1 1]';
x = w * o4;

for i = 1:4
    for j = 1
        if(x(i,j) >= 1 )
            x(i,j) = 1;
        else
            x(i,j) = 0;
        end
    end
end

x


