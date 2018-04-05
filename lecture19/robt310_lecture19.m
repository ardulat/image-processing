%% ROBT 310 - Lecture 19 - Morphological Image Processing

clc; clear; close all; % Clear the environment


%% DEMO 0 - Scanned Character Enhancement
I = imread('broken_text.png');
figure(1);  imshow(I); title('Broken Text','FontWeight','Demi','FontSize',12);
sel = [0 1 0 ; 1 1 1; 0 1 0]; 
I2 = imdilate(I, sel);  figure(2); imshow(I2); title('Dilated','FontWeight','Demi','FontSize',12); 
sel = ones(2,2);
I3 = imerode(I2, sel);  figure(3); imshow(I3); title('Eroded after dilation','FontWeight','Demi','FontSize',12); 

%% DEMO 1 -  Load a Noisy Fingerprint Image
close all; 
I = imread('noisy_fingerprint.tif');
figure(1); imshow(I); title('Noisy Fingerprint','FontWeight','Demi','FontSize',12);

se1 = strel('square',3);    % Create a square structural element of size 13

% Step 1 - Erosion
I1 = imerode(I, se1);
figure(2); imshow(I1); title('Eroded Fingerprint','FontWeight','Demi','FontSize',12);

% Step 2 - Dilation (Get rid of the noise and go back to the original)
I2 = imdilate(I1, se1);
figure(3); imshow(I2); title('Dilation after Erosion (Opening)','FontWeight','Demi','FontSize',12);


% Step 3 - Closing of the Opening (Merge disconnected segments)
I3 = imerode( imdilate(I2, se1), se1) ;
figure(4); imshow(I3); title('Closing of the opening','FontWeight','Demi','FontSize',12);

% As en exercise play with the size of the structural element and observe the differences 
% Employ different Struc. El. Sizes for each operation and get a qualitatively better result


%% DEMO 2 - Remove Small Squares
close all; 
I = imread('squares.bmp');
I = I > 0;
figure(1); imshow(I); title('Noisy Rectangles','FontWeight','Demi','FontSize',12);

sel = ones(13);
I2 = imerode(~I, sel);
figure(2); imshow(I2);
I3 = imdilate(I2, sel);
figure(3); imshow(I3);

