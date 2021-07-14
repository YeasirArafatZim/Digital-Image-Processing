clear; close all; clc;
img = imread('img1.jpg');

sig = input('Enter the Sigma Value: ');
output = gaussianFilter(img,sig,5);

figure;
subplot(1,2,1);
imshow(rgb2gray(img));
title('Gray');
subplot(1,2,2);
imshow(output); 
title('Output Image(Kernel Size 5 X 5)');

function img = gaussianFilter(image, sigma, filter_size)
    % rgb to gray convertion
    img_gray = rgb2gray(image);
    [row,col] = size(img_gray);
    m = floor(filter_size/2);
    % creating new image with zero padding
    newImg = zeros(row + 2*m, col + 2*m,'uint8');
    newImg(3:row+2,3:col+2) = img_gray(:,:);
    newImg = im2double(newImg);
    
    % creating Gaussian Kernel
    gaussian_filter = zeros(filter_size,filter_size);
    
    const = 1 /(2*pi*sigma^2);
    for x = -m:m
        for y = -m:m
            expon = exp(-(x^2 + y^2) / (2 * sigma^2));
            gaussian_filter(x+m+1,y+m+1) = const * expon;
        end
    end
    
    % Applying Gaussian Filter
    [row,col] = size(newImg);
    for i = m+1:row-m
       for j = m+1:col-m
           N = newImg(i-m : i+m, j-m : j+m);
           t = gaussian_filter .* N;
           t = sum(t(:));
           newImg(i,j) = t;
       end
    end
    [row,col] = size(newImg);
    img = newImg(m+1:row-m,m+1:col-m);
    
end
