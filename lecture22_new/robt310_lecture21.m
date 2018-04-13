%% ROBT 310 - Lecture 21 - Image Segmentation

clc; clear; close all; % Clear the environment


%% DEMO 0 - Gradient Operators
I = double(imread('building.tif'));

h1 = [-1 -2 -1; 0 0 0; 1 2 1];
h2 = [-1 0 1; -2 0 2; -1 0 1];

I1 = abs( imfilter(I, h1));
I1 = (I1 - min(I1(:)) )/ ( max(I1(:)) - min(I1(:)) ) ; % Scale to the range [0, 1]
I2 = abs( imfilter(I, h2));
I2 = (I2 - min(I2(:)) )/ ( max(I2(:)) - min(I2(:)) ) ; % Scale to the range [0, 1]

I3 = I1 + I2;

figure(2);
imshow( I1 );
title('Absolute Value of the Horizontal Sobel Operator' , 'FontWeight', 'Demi', 'FontSize',12);

figure(3);
imshow( I2 );
title('Absolute Value of the Vertical Sobel Operator' , 'FontWeight', 'Demi', 'FontSize',12);

figure(4);
imshow( I3 );
title('Vertical and Horizontal Edges' ,'FontWeight', 'Demi', 'FontSize',12);

% figure(4);
% I4 = atan2(I2, I1);
% I4 = (I4 - min(I4(:)) )/ ( max(I4(:)) - min(I4(:)) ) ; % Scale to the range [0, 1]
% imshow( I4 );
% title('Angle of the Gradient for Each Pixel' ,'FontWeight', 'Demi', 'FontSize',12);

%% Averaging
I = double(imread('building.tif'));

h1 = [-1 -2 -1; 0 0 0; 1 2 1];
h2 = [-1 0 1; -2 0 2; -1 0 1];

I1 = abs( imfilter(I, h1));
I1 = (I1 - min(I1(:)) )/ ( max(I1(:)) - min(I1(:)) ) ; % Scale to the range [0, 1]
I2 = abs( imfilter(I, h2));
I2 = (I2 - min(I2(:)) )/ ( max(I2(:)) - min(I2(:)) ) ; % Scale to the range [0, 1]

I3 = I1 + I2;

h3 = ones(5,5)/25;
I4 = abs(imfilter(I3,h3));

figure(1); imshow(I4); title('Smoothed image');

I5 = I4 > 0.2;
figure(2); imshow(I5); title('Thresholded image');

%% Hough Transform

close all;
I = imread('airport.png');
I = double( rgb2gray(I)) ;
I = (I - min(I(:))) / ( max(I(:)) - min(I(:)) ); % Convert the image to double and scale to [0, 1]

figure(1);
imshow(I);
title('Airport - Original Image' , 'FontWeight', 'Demi', 'FontSize',12);

I3 = edge(I,'canny', 0.6);  % Canny edge detector
 
figure(3)
imshow(I3);
title('Detected edges of the image' , 'FontWeight', 'Demi', 'FontSize',12);

[I, J] = find(I3 == 1);
rand_ind = randperm(length(I));
I = I( rand_ind(1:500) );
J = J( rand_ind(1:500) );

theta = 0:0.1:2*pi;

f = figure(4);
set(f, 'Position', [100 100 1200 800]);
hold on;
for ind = 1:length(I)
    ro = I(ind)*cos(theta) + J(ind)*sin(theta);
    plot(theta, ro);   
    title( ['Iteration ', num2str(ind) ]);
    xlabel('Theta' , 'FontWeight', 'Demi', 'FontSize',12);
    ylabel('{Rho}' , 'FontWeight', 'Demi', 'FontSize',12);
    axis([ 0 2*pi -600 600]); 
    pause(0.01);
end
hold off; 

%% Demo 3 - Write a Program which applies Sobel edge detection to an image
% and then links the edges based on gradient and angle thresholds. (Lecture 21 Slide 24)
