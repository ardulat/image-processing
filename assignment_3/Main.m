% ROBT 310 - Project 3
%
% Author: Anuar Maratkhan
% Date: 1 March 2018

close all ; clc; clear;

%%
vid = VideoReader('robt310_proj3_expert_amaratkhan.avi');
frames = vid.NumberOfFrames;

output = VideoWriter('result.avi');
open(output);

% process the video
for i = 1:frames
   img = read(vid,i);
   img(:,:,1) = medfilt2(img(:,:,1));
   img(:,:,2) = medfilt2(img(:,:,2));
   img(:,:,3) = medfilt2(img(:,:,3));
   
   writeVideo(output,img);
end

close(output);

implay('result.avi');

%%
img = readFrame(vid);

% median filter
gray = rgb2gray(img);
median = medfilt2(gray);
f = fftshift(fft2(median));
fabs = log(abs(f));
thresh = 0.75*max(fabs(:));
mask = fabs > thresh;
filteredImage = 255*fftshift(ifft2(f.*f));
filteredImage = uint8(255*mat2gray(filteredImage));
filteredImage = median - filteredImage;

figure(1);imshowpair(img,median,'montage');
figure(2);imshowpair(median,filteredImage,'montage');





