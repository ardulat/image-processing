% ROBT 310 - Assignment 2
%
% Author: Anuar Maratkhan
% Date: 15 Feb 2018

close all ; clc; clear;

% first task
ditheredImage1 = robt310_project2_dither('lena_std.tiff','output_1.jpg',1);
figure(1);
imshow(ditheredImage1);

% second task
ditheredImage2 = robt310_project2_dither('lena_std.tiff','output_2.jpg',2);
figure(2);
imshow(ditheredImage2);

% third task
ditheredImage3 = robt310_project2_dither('lena_std.tiff','output_3.jpg',3);
figure(3);
imshow(ditheredImage3);

% easter egg
ditheredImage42 = robt310_project2_dither('lena_std.tiff','output_42.jpg',42);
figure(42);
imshow(ditheredImage42);
