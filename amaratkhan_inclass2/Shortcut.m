% ROBT 310 - Lecture 8 Inclass exercise
%
% Author: Anuar Maratkhan
% Date: 6 Feb 2018

%%
close all ; clc; clear;     % Close all figure windows, Clear the screen and the workspace memory

%% Construct image
img = ones(500,500,'uint8')*255;
imgSize = size(img);
img = insertText(img,[imgSize(1)/2-5*72/2 imgSize(2)/2-72],'ANUAR','FontSize',72,...
    'BoxColor','white');
img_ref = imref2d(size(img));

imshow(img,img_ref);


%% Scale image
S = [2 0 0; 0 1.5 0; 0 0 1];
tform_s = affine2d(S);
[newImg,newImg_ref] = imwarp(img,tform_s);
subplot(121);
imshow(img, img_ref);
subplot(122);
imshow(newImg, newImg_ref);

%% Rotate image
theta = pi/4;
R = [cos(theta) sin(theta) 0; -sin(theta) cos(theta) 0; 0 0 1];
tform_r = affine2d(R);
[newImg, newImg_ref] = imwarp(img,tform_r);
subplot(121);
imshow(img,img_ref);
subplot(122);
imshow(newImg,newImg_ref);
%% Translate image
T = [1 0 0;0 1 0;100 100 1];
tform_t = affine2d(T);
[newImg,newImg_ref] = imwarp(img,tform_t);

subplot(121);
imshow(img, img_ref);
subplot(122);
imshow(newImg,newImg_ref);

%% Sheer (Vertical)
V = [1 0 0; -0.5 1 0; 0 0 1];
tform_v = affine2d(V);
[newImg, newImg_ref] = imwarp(img,tform_v);

subplot(121);
imshow(img,img_ref);
subplot(122);
imshow(newImg,newImg_ref);

%% Sheer (Horizontal)
H = [1 -0.5 0; 0 1 0; 0 0 1];
tform_h = affine2d(H);
[newImg,newImg_ref] = imwarp(img,tform_h);

subplot(121);
imshow(img,img_ref);
subplot(122);
imshow(newImg,newImg_ref);
