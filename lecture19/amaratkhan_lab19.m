%% ROBT 310 - Lecture 19 - Morphological Image Processing

clc; clear; close all; % Clear the environment

%% clearing the noise from fingerprint image

img = imread('noisy_fingerprint.tif');
element_1 = strel('square',3);
element_2 = strel('disk',1,0);

% erosion (get rid of noise)
newImg_1 = imerode(img,element_2);

% dilation (go back to the original)
newImg_2 = imdilate(newImg_1, element_2);

% closing of the opening (connecting segments)
newImg_3 = imerode(imdilate(newImg_2,element_2), element_2);

% trying to apply closing one more time
% newImg_3 = imerode(imdilate(newImg_3,element_1), element_1);

figure(1);
subplot(141); imshow(img); title('Noisy fingerprint');
subplot(142); imshow(newImg_1); title('Erosion applied');
subplot(143); imshow(newImg_2); title('Dilation applied');
subplot(144); imshow(newImg_3); title('Closing applied');



