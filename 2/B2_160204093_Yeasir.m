clear all; clc; close all;
img = imread('pep.jpg');
I = rgb2gray(img);
[row,col]=size(I);
figure;
subplot(5,2,1);
imshow(I);
title('Gray');
subplot(5,2,2);
bar(hist(I));   %'Histogram of Grayscale image'


% input Gamma
y = input('Input Gamma value for Power Law Transformation: ');
% Power Law Transformation
plt_img = pl_trans(I,y);
subplot(5,2,3);
imshow(plt_img);
title('Power Law Transformation');
subplot(5,2,4);
bar(hist(plt_img));


% input Threshold value
a = input('Input Threshold value : ');
% Adjust brightness
image_threshold = adj_brightness(I,a);
subplot(5,2,5);
imshow(image_threshold);
title('Brightness change');
subplot(5,2,6);
bar(hist(image_threshold));


% Log Transformation
log_img = log_trans(I);
subplot(5,2,7);
imshow(log_img);
title('Log Transformation');
subplot(5,2,8);
bar(hist(log_img));


% Negative image with histogram
neg_img = negative_image(I);
subplot(5,2,9);
imshow(neg_img);
title('Negative Image');
subplot(5,2,10);
bar(hist(neg_img));



% Negative image
function img = negative_image(image)
    img = 255 - image;
end

% Adjust brightness
function image_thresholded = adj_brightness(image,threshold)
    image_thresholded = zeros(size(image),'uint8');
    for i=1:size(image,1)
        for j=1:size(image,2)
            % check pixel value and assign new value
            if image(i,j) < threshold
                image_thresholded(i,j) = image(i,j) + image(i,j)*.5;
            else
                image_thresholded(i,j) = image(i,j) - image(i,j)*.25;
            end
        end
    end
end


% Power Law Transformation
function img = pl_trans(image,y)
    c = 1.5;
    new_img = im2double(image);
    plt_img = c * (new_img.^y); 
    img = im2uint8(plt_img);
end


% Log Transformation
function img = log_trans(image)
    c = 1.5;
    new_img = im2double(image);
    img = c * (log(new_img + 1)); 
    img = im2uint8(img);
end


% Histogram calculation and plot
function X = hist(image)
    [r,c]=size(image);
    X=zeros(1,256);
    for i=1:r
        for j=1:c
                   temp = image(i,j)+1;
                   X(temp) = X(temp)+1;   
        end
    end
end

