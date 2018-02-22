% ROBT 310 - Lecture 8 Matlab Codes
%
% Author: Atakan Varol
% Date: 10 Feb 2014

%%
close all ; clc; clear;     % Close all figure windows, Clear the screen and the workspace memory

%% Step 1 - Read the original image
I = im2double(imread('skeleton_orig.tif'));
figure(1); imshow(I); title('Bone Scan Image'); 

% Prepare the filters
h_laplacian = [-1 -1 -1; -1 8 -1; -1 -1 -1]; 
h_sob_ver = [-1 -2 -1; 0 0 0; 1 2 1]; 
h_sob_hor = [-1 0 1; -2 0 2; -1 0 1]; 
h_smooth = ones(5,5)/25; 

%% Step 2 - Laplacian Filtering 
I_lap = conv2(I, h_laplacian, 'same');  % Laplacian Filtering 
% Normalize Laplacian of the image for display purposes
I_lap_norm = [I_lap - min(I_lap(:))] ./ max(I_lap(:) - min(I_lap(:))); 
figure(2); imshow(I_lap_norm); title('Laplacian Image'); 

%% Step 3 - % Image Sharpening
I_sharp = I + I_lap;  
figure(3); imshow(I_sharp); title('Enhanced Laplacian Image'); 

%% Step 4 -  Pronounce the Edges of the Original Image
I_sobel = abs(conv2(I, h_sob_ver, 'same')) + abs(conv2(I, h_sob_hor, 'same')); 
figure(4); imshow(I_sobel); title('Sobel Image'); 

%% Step 5 - Smooth the Image using Averaging Filter
I_smooth = conv2(I_sobel, h_smooth, 'same');   
figure(5); imshow(I_smooth); title('Sobel 5x5 Smoothed'); 

%% Step 6 - Create a Mask using Sobel and Sharp
I_mask = I_sharp.*I_sobel;            
figure(6); imshow(I_mask); title('Mask Image'); 

%% Step 7 - Sharpen the Image again using the Mask
I_sharp2 = I + I_mask;   
figure(7); imshow(I_sharp2); title('Sharpened Image'); 

%% Step 8 - Apply Power Law to Enhance Image Contrast
I_pow = I_sharp2.^0.7;                 % Apply power law to enhance contrast
figure(8); imshow(I_pow); title('Power-law Image'); 

