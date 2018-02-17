% ROBT 310 - Assignment 2
%
% Author: Anuar Maratkhan
% Date: 15 Feb 2018

%%
close all ; clc; clear;

%% First task
I = imread('lenna.jpg');

I = histeq(I); % image enhancement

[rows cols] = size(I);

newImg = I;
none = newImg;

none = I > 256/2;

newImg = floyd_steinberg_dithering(newImg,1);

figure(1);
subplot(131); imshow(I); title('Original image');
subplot(132); imshow(none); title('No dithering');
subplot(133); imshow(newImg); title('Dithered image');

%% Second task

I_1 = imread('lena512color.tiff');
[rows cols] = size(I_1);

I_1(:,:,1) = histeq(I_1(:,:,1));
I_1(:,:,2) = histeq(I_1(:,:,2));
I_1(:,:,3) = histeq(I_1(:,:,3));

r = I_1(:,:,1);
g = I_1(:,:,2);
b = I_1(:,:,3);

newImg = I_1;
none_1 = newImg;

for i = 1:size(none_1,1)
    for j = 1:size(none_1,2)
        for k = 1:size(none_1,3)
            oldpixel = none_1(i,j,k);
            newpixel = find_closest_palette_color(oldpixel,8);
            none_1(i,j,k) = newpixel;
        end
    end
end

r = floyd_steinberg_dithering(r,3);
g = floyd_steinberg_dithering(g,3);
b = floyd_steinberg_dithering(b,3);

newImg(:,:,1) = r;
newImg(:,:,2) = g;
newImg(:,:,3) = b;

figure(2);
subplot(131); imshow(I_1); title('Original image');
subplot(132); imshow(none_1); title('No dithering');
subplot(133); imshow(newImg); title('Dithered image');


%% Third task
newImg = ordered_dithering(I);

figure(3);
subplot(131); imshow(I); title('Original image');
subplot(132); imshow(none); title('No dithering');
subplot(133); imshow(newImg); title('Dithered image');

% newImg = I_1;
% 
% r = ordered_dithering(r);
% g = ordered_dithering(g);
% b = ordered_dithering(b);
% 
% newImg(:,:,1) = r;
% newImg(:,:,2) = g;
% newImg(:,:,3) = b;
% 
% figure(4);
% subplot(131); imshow(I_1); title('Original image');
% subplot(132); imshow(none_1); title('No dithering');
% subplot(133); imshow(newImg); title('Dithered image');
