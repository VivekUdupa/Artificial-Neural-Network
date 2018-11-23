function results = vec_to_img(vec)

    %This function converts vectors (stored in vec) to image
    
    x = length( vec(1,:) ); %number of test data
    
    %define the size of the image interms of pixels
    rows = 11;
    cols = 8;
    
    for i = 1:x %convert all test result to image
           %convert test_final vector into matrix of rows x cols
           matrix(:,:,i) = reshape(vec(:,i),[cols rows]); 
           
           %transpose it to get it into original image orientation
           img_matrix(:,:,i) = matrix(:,:,i)';
                      
           %now convert values from [-1 1] to [0 255]
           p = matrix_to_image(img_matrix(:,:,i));
           results(:,:,i) = p;
%            figure(i)
%            imshow(results);
    end %for all test_final entries
end%function