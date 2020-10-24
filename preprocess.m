function normalized = preprocess(img, dims_img)
    colored = imread(img);                  % Read an image (by default it will be read as 3-channel [colorful] image
    grayscaled = rgb2gray(colored);         % Grayscale the colorful image (convert the 3-channel image into 1-channel image)
    inverted=imcomplement(grayscaled);      % Inverting grayscaled image colors (black on white, into white on black)
    resized = imresize(inverted, dims_img); % Resize an image dimensions to be of the specified dimensions

    % Thresholding (Binarization)
%     threshold = 60;       
%     resized(resized >= threshold) = 255;    % a pixel greater than or equal the threshold value need to be 255 (absolute white)
%     resized(resized < threshold) = 0;       % a pixel less than the threshold value need to be 0 (absolute black)
% 
%     figure, imshow(colored)
%     figure, imshow(resized)

    normalized = double(resized)/255;       % Scale down pixels representation from being [0 ~ 255] range, to be [0 ~ 1] range            
end