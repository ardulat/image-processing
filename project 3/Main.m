% ROBT 310 - Project 3
%
% Author: Anuar Maratkhan
% Date: 1 March 2018

close all ; clc; clear;

%% accomplished task
vid = VideoReader('robt310_proj3_expert_amaratkhan.avi');
frames = vid.NumberOfFrames;

output = VideoWriter('result.avi');
open(output);

sharedSpikes = ones(512,512);

% process the video
for i = 1:frames
   img = read(vid,i);
   grayImage = rgb2gray(img);
   
   grayImage = medfilt2(grayImage);
   
%    [grayImage, sharedSpikes] = frequency_noise(grayImage, sharedSpikes);
   
   writeVideo(output,grayImage);
end

% sharedSpikes(256:258,256:258) = 0;
% % exclude vertical lines
% sharedSpikes(:,257) = 0;

% imwrite(sharedSpikes, 'shared.png')

close(output);

implay('result.avi');

%% remove shared spikes

close all; clear; clc;

vid = VideoReader('result.avi');
frames = vid.NumberOfFrames;

output = VideoWriter('result_1.avi');
open(output);

% process the video
for i = 1:frames
   img = read(vid,i);
   grayImage = rgb2gray(img);
   
   grayImage = remove_sharedSpikes(grayImage);
   
   writeVideo(output,grayImage);
end

close(output);

implay('result_1.avi');

%% removing horizontal line
vid = VideoReader('result_1.avi');

frames = vid.NumberOfFrames;

cube = ones(512,512,frames, 'uint8');

for i = 1:frames
    img = read(vid,i);
    grayImage = rgb2gray(img);
    
    cube(:,:,i) = grayImage;
end

time_domain = permute(cube,[1 3 2]);

for i = 1:frames
    time_domain(:,:,i) = remove_cubicNoise(time_domain(:,:,i));
end

cube = permute(time_domain, [1 3 2]);

output = VideoWriter('result_2.avi');
open(output);

for i = 1:frames
    writeVideo(output,cube(:,:,i));
end

close(output);

implay('result_2.avi');
