% ROBT 310 - Lecture 11 Matlab Codes
%
% Author: Anuar Maratkhan
% Date: 27 Feb 2018

%%
close all ; clc; clear;     % Close all figure windows, Clear the screen and the workspace memory

%% Read image
img = im2double(imread('skeleton_orig.tif'));
figure(1); imshow(img);

% Filters
laplacian = [0 1 0; 1 -4 1; 0 1 0];
sobel_hor = [-1 -2 -1; 0 0 0; 1 2 1];
sobel_ver = [-1 0 1; -2 0 2; -1 0 1];
smooth = ones(5,5)/25;

%% Laplacian filter
img1 = conv2(img,laplacian, 'same');
laplacian_result = img1 - min(img1(:));
img1 = img - img1; % lecture slides state that we need to SUBTRACT
figure(2); imshow(laplacian_result);
figure(3); imshow(img1);

%% Sobel filter
img2 = abs(conv2(img,sobel_hor,'same')) + abs(conv2(img,sobel_ver,'same'));
figure(4); imshow(img2);

%% Smoothed Sobel
img3 = conv2(img2,smooth,'same');
figure(5);imshow(img3);

%% Produce mask
img4 = img3 .* img1;
figure(6); imshow(img4);

%% Sharpened image sum
img5 = img4 + img;
figure(7); imshow(img5);

%% Power law transform
img6 = img5 .^ 0.7;
figure(8); imshow(img6);

%% All in one
close all;

figure(1);
subplot(241); imshow(img); title('Original image');
subplot(242); imshow(laplacian_result); title('Laplacian filter');
subplot(243); imshow(img1); title('Subtracting Laplacian');
subplot(244); imshow(img2); title('Sobel filter');
subplot(245); imshow(img3); title('Smoothed Sobel');
subplot(246); imshow(img4); title('Mask image');
subplot(247); imshow(img5); title('Sharpened image');
subplot(248); imshow(img6); title('Power law transform');
