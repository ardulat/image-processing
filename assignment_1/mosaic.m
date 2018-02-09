% ROBT 310 - Project assignment 1
%
% Author: Anuar Maratkhan
% Date: 29 Jan 2017

close all ; clc; clear; % Close all figure windows, Clear the screen and the workspace memory

tic; % start time

newImg = create_mosaic('mandrill.png','dataset',16,'circular');

imshow(newImg);

toc % end time