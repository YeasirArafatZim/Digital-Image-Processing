clear all; clc; close all;
img = imread('input.png');
img = rgb2gray(img);
[row,col]=size(img);

% Step - 1
figure;
subplot(2,4,1);
imshow(img);
title('Figure a');

% Step - 2 ( Laplacian Filter )
lapImg = laplacianFilter(img);
subplot(2,4,2);
imshow(lapImg,[]);
title('Figure b');


% Step - 3 ( Laplacian Enhanced Image )
lapEnImg = im2double(img) - lapImg;
subplot(2,4,3);
imshow(lapEnImg);
title('Figure c');


% Step - 4 ( Applying Sobel Filter )
sobImg = sobelFilter(img);
subplot(2,4,4);
imshow(sobImg);
title('Figure d');


% Step - 5 ( 5x5 Average filtering )
avgImg = avgFilter(im2uint8(sobImg));
subplot(2,4,5);
imshow(avgImg);
title('Figure e');


% Step - 6 ( Product of c and e )
pImg = lapEnImg .* avgImg;
subplot(2,4,6);
imshow(pImg);
title('Figure f');


% Step - 7 ( Add a and f )
aImg = im2double(img) + avgImg;
subplot(2,4,7);
imshow(aImg);
title('Figure g');


% Step - 8 ( Applying Power Law Transformation )
c = 1; y = 0.5;
plImg = pl_trans(img,y,c);
subplot(2,4,8);
imshow(plImg);
title('Figure h');

% Laplacian Filter
function img = laplacianFilter(image)
    mask = [0   1   0; 1   -4  1; 0   1   0];
    [row,col] = size(image);
    
    % creating new image with zero padding
    paddingImg = zeros(row + 2, col + 2,'uint8');
    paddingImg(2:row+1,2:col+1) = image(:,:);
    paddingImg = im2double(paddingImg);
    
    % Applying filter
    img = applyFilter(paddingImg,mask);
end

% Apply Filter
function img = applyFilter(paddingImg,filter)
    [row,col] = size(paddingImg);
    filterImg = paddingImg;
    for i = 2:row-1
       for j = 2:col-1
           N = paddingImg(i-1 : i+1, j-1 : j+1);
           t = N .* filter;
           t = sum(t(:));
           filterImg(i,j) = t;
       end
    end
    img = filterImg(2:row-1, 2:col-1); % Remove padding
end

% Sobel Operator
function img = sobelFilter(image)
    [row,col] = size(image);
    gx = [-1  0   1; -2   0  2; -1   0   1];
    gy = [-1  -2  -1; 0   0  0; 1   2   1];
    % creating new image with zero padding
    paddingImg = zeros(row + 2, col + 2,'uint8');
    paddingImg(2:row+1,2:col+1) = image(:,:);
    paddingImg = im2double(paddingImg);
    
    % Horizontal edges
    h = applyFilter(paddingImg, gx);
    v = applyFilter(paddingImg, gy);
    img = h + v;
end

% Average filter
function img = avgFilter(image)
    [row,col] = size(image);
    % creating new image with zero padding
    paddingImg = zeros(row + 4, col + 4,'uint8');
    paddingImg(3:row+2,3:col+2) = image(:,:);
    paddingImg = im2double(paddingImg);
    
    % Applying filter
    [row,col] = size(paddingImg);
    filterImg = paddingImg;
    for i = 3:row-2
       for j = 3:col-2
           N = paddingImg(i-2 : i+2, j-2 : j+2);
           t = mean(N(:));
           filterImg(i,j) = t;
       end
    end
    img = filterImg(3:row-2, 3:col-2); % Remove padding
end

% Power Law Transformation
function img = pl_trans(image,y,c)
    new_img = im2double(image);
    plt_img = c * (new_img.^y); 
    img = im2uint8(plt_img);
end
