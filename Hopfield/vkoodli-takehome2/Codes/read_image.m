function x = read_image(img,path)
   %this function convers image from png to column vector with pixel values
   %and then convert 
    
    img = strcat(path,img); %to access perticular folder
    imshow (img); %display the image( getimage needs image to be displayed to extract pixel values)
    I = getimage; %extract pixel value from the image
    close; %close the image after reading the pixel value
    
    I = I'; 
    x = I(:);
    
%     I = double(I);
    x = double(x);

    for i = 1:length(x)
        if(x(i,1) == 0)
            x(i,1) = -1;
        else
            x(i,1) = 1;
        end
    end
    
end