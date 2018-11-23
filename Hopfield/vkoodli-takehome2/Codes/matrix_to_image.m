function image = matrix_to_image(matrix) 

    rows = length( matrix(:,1));
    cols = length( matrix(1,:));
    image = zeros(rows,cols);
    
    for i = 1:rows
        for j = 1:cols
            if( matrix(i,j) > 0)
                image(i,j) = 255;
            else
                image(i,j) = 0;
            end
        end
    end
    

end %function