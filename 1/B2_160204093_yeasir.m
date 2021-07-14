clear; close all; clc;
img1 = imread('img1.jpg');
img2 = imread('img2.jpg');
[row,col,chan] = size(img1);
newImg = ones(row,col,chan,'uint8');

% task 4
rowDif = row/5;
colDif = col/5;

rflag = 1;
for j = 1: 2*rowDif :(row-rowDif+1)
    cflag = 1;
    for i = 1: 2*colDif :(col-colDif+1)
        newImg(rflag:rflag+rowDif-1,cflag:cflag+colDif-1,:) = img1(rflag:rflag+rowDif-1,cflag:cflag+colDif-1,:);
        cflag = cflag + rowDif;
        if(cflag < col - colDif)
            newImg(rflag:rflag+rowDif-1,cflag:cflag+colDif-1,:) = img2(rflag:rflag+rowDif-1,cflag:cflag+colDif-1,:);
            cflag = cflag + rowDif;
        end
    end
    rflag = rflag + 2*rowDif;
end



rflag = rowDif + 1;
for j = 1: 2*rowDif :(row-rowDif)
    cflag = 1;
    for i = 1: 2*colDif :(col-colDif+1)
        newImg(rflag:rflag+rowDif-1,cflag:cflag+colDif-1,:) = img2(rflag:rflag+rowDif-1,cflag:cflag+colDif-1,:);
        cflag = cflag + colDif;
        if(cflag < col - colDif)
            newImg(rflag:rflag+rowDif-1,cflag:cflag+colDif-1,:) = img1(rflag:rflag+rowDif-1,cflag:cflag+colDif-1,:);
            cflag = cflag + colDif;
        end
    end
    rflag = rflag + 2*rowDif;
end
f1 = figure;
imshow(newImg);


%task 5
rotImg = ones(row,col,chan,'uint8');
for i = 1:row
   for j = 1 :col
      rotImg(i,j,:) = newImg(j,i,:); 
   end
end
f2 = figure;
imshow(rotImg);

