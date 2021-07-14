clc;clear all;close all;
img =[0 0 0 0 0 0 0;
   0 0 0 0 0 0 0;
   0 0 1 0 1 0 0;
   0 0 1 0 1 0 0;
   0 0 1 1 1 0 0;
   0 0 0 0 0 0 0;
   0 0 0 0 0 0 0];

subplot(2,2,1);
imshow(img);
title('Original image');

[x,y]=size(img);
p=zeros(x,y);

w=[ 0 1 0; 
    1 1 1;
    0 1 0];

img = imbinarize(img);
subplot(2,2,2);
imshow(img);
title('Binarized image');

%Dilation
for s=2:x-1
    for t=2:y-1
        w1=[img(s-1,t-1)*w(1) img(s-1,t)*w(2) img(s-1,t+1)*w(3) img(s,t-1)*w(4) img(s,t)*w(5) img(s,t+1)*w(6) img(s+1,t-1)*w(7) img(s+1,t)*w(8) img(s+1,t+1)*w(9)];
        p(s,t)=max(w1);
    end  
end

subplot(2,2,3);
imshow(p);
title('Dialated image');

%subtracting to get output
subplot(2,2,4);
imshow(p-img);
title('Output Image');
