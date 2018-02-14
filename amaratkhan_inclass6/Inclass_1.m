clc; clear;

img = imread('mri.jpg');
gray = rgb2gray(img);

% changed_2 = ChangeIntensity(gray,2);
% changed_4 = ChangeIntensity(gray,4);
changed_8 = ChangeIntensity(gray,8);
% changed_16 = ChangeIntensity(gray,16);
% changed_32 = ChangeIntensity(gray,32);
% changed_64 = ChangeIntensity(gray,64);
% changed_128 = ChangeIntensity(gray,128);
% 
% f = figure;
% imshow([changed_2 changed_4 changed_8 changed_16;
%     changed_32 changed_64 changed_128 gray]);
% saveas(f, 'result.png');

% CHANGE INTENSITY - 8 colors
newVal = gray/32;
newGray = newVal*32;

figure(1);
subplot(131); imshow(gray); title('Original');
subplot(132); imshow(newGray); title('Not Original');
subplot(133); imshow(changed_8); title('Changed');

% newGray = logical(gray/255);
% figure(2); imshow(newGray);