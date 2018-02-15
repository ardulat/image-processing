% ROBT 310 - Assignment 2
%
% Author: Anuar Maratkhan
% Date: 15 Feb 2018

%%
close all ; clc; clear;

%% First task
I = imread('lenna.jpg');
[rows cols] = size(I);

newImg = I;
none = newImg;

for i = 1:size(none,1)
    for j = 1:size(none,2)
        oldpixel = none(i,j);       
        newpixel = find_closest_palette_color(oldpixel,1);
        none(i,j) = newpixel;
    end
end
        
newImg = floyd_steinberg_dithering(newImg,1);

figure(1);
subplot(131); imshow(I); title('Original image');
subplot(132); imshow(none); title('No dithering');
subplot(133); imshow(newImg); title('Dithered image');

%% Second task

I = imread('lena512color.tiff');
[rows cols] = size(I);

I(:,:,1) = histeq(I(:,:,1));
I(:,:,2) = histeq(I(:,:,2));
I(:,:,3) = histeq(I(:,:,3));

r = I(:,:,1);
g = I(:,:,2);
b = I(:,:,3);

newImg = I;
none = newImg;

for i = 1:size(none,1)
    for j = 1:size(none,2)
        for k = 1:size(none,3)
            oldpixel = none(i,j,k);
            newpixel = find_closest_palette_color(oldpixel,8);
            none(i,j,k) = newpixel;
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
subplot(131); imshow(I); title('Original image');
subplot(132); imshow(none); title('No dithering');
subplot(133); imshow(newImg); title('Dithered image');

