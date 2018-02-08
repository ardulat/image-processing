% ROBT 310 - Lecture 8 Matlab Codes
%
% Author: Anuar Maratkhan
% Date: 8 Feb 2017

%%
close all ; clc; clear;     % Close all figure windows, Clear the screen and the workspace memory

%% Lecture 8 - Slide 8
img = imread('Fig0304(a)(breast_digital_Xray).tif');
newImg = 255-img;
subplot(121); imshow(img); title('Original Image');
subplot(122); imshow(newImg); title('Negative Image');

%% Lecture 8 - Slide 8
img = imread('Fig0308(a)(fractured_spine).tif');
threshold = round(255/2);
newImg = img > threshold;

subplot(121); imshow(img); title('Original Image');
subplot(122); imshow(newImg); title('Thresholded Image');

%% Lecture 8 - Slide 12
img = imread('Fig0305(a)(DFT_no_log).tif');
newImg = log(1+10*double(img)/255);
subplot(121); imshow(img); title('Original Image');
subplot(122); imshow(newImg); title('Logarithmic Transformation');

%% Lecture 8 - Slide 19
img = imread('Fig0308(a)(fractured_spine).tif');
img_1 = double(img)/255;
newImg_1 = img_1.^0.8;
newImg_2 = img_1.^0.6;
newImg_3 = img_1.^0.4;
subplot(221); imshow(img); title('Original Image');
subplot(222); imshow(newImg_1); title('gamma = 0.8');
subplot(223); imshow(newImg_2); title('gamma = 0.6');
subplot(224); imshow(newImg_3); title('gamma = 0.4');

%% Lecture 8 - Slide 22
img = imread('Fig0309(a)(washed_out_aerial_image).tif');
img_1 = double(img)/255;
newImg_1 = img_1.^2;
newImg_2 = img_1.^4;
newImg_3 = img_1.^6;
subplot(221); imshow(img); title('Original Image');
subplot(222); imshow(newImg_1); title('gamma = 2.0');
subplot(223); imshow(newImg_2); title('gamma = 4.0');
subplot(224); imshow(newImg_3); title('gamma = 6.0');

%% Lecture 8 - Slide 24
img = imread('Fig0310(b)(washed_out_pollen_image).tif');
threshold_1 = 100;
threshold_2 = 175;
level_1 = 50;
level_2 = 200;

imgSize = size(img);
newImg = zeros(imgSize);
for i = 1:imgSize(1)
    for j = 1:imgSize(2)
        if img(i,j) < threshold_1
            newImg(i,j) = img(i,j)*0.5;
        elseif img(i,j) < threshold_2
            newImg(i,j) = img(i,j)*2-150;
        else
            newImg(i,j) = img(i,j)*11/16+1275/16;
        end
    end
end
disp(newImg(1:10,1:10));
newImg = uint8(newImg);
subplot(121); imshow(img);
subplot(122); imshow(newImg);

%% Lecture 8 - Slide 28
img = imread('Fig0314(a)(100-dollars).tif');
subplot(331); imshow(img);
[rows, cols] = size(img);
for i = 1:8
    newImg = bitand(img,2^i-1)*2^(8-i);
    subplot(3,3,i+1); imshow(newImg);
end
