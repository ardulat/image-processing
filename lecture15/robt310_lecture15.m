%% ROBT 310 - Lecture 15 - Color Image Processing Examples
%

clc; clear; close all; % Clear the environment

%% Spatial Domain Sobel Filter
%Create the Spacial Filtered Image
I = imread('parrot.jpg');
I = imresize(I, 0.5);
figure(1); imshow(I);

% Show only the red band of the picture
I_red = zeros(size(I),'uint8');
I_red(:,:,1) = I(:,:,1);
figure(2); imshow(I_red);

% Show the red regions of the image in their original color and the other
% regions as gray.
[M N C] = size(I);
color_center = [255 0 0];
color_rad = 100;
I2 = double(I);
for ind1 = 1:M
    for ind2 = 1:N
        if sqrt(sum( (squeeze( I2(ind1, ind2, :))' - color_center).^2 ) ) > color_rad
            I2(ind1,ind2,:) = 127;
        end
    end
end
figure(3);  imshow(uint8(I2));

%% Shindler's List effect
[M N C] = size(I);
color_center = [255 0 0];
color_rad = 100;
I2 = double(I);
for ind1 = 1:M
    for ind2 = 1:N
        if sqrt(sum( (squeeze( I2(ind1, ind2, :))' - color_center).^2 ) ) > color_rad
            I2(ind1,ind2,:) = mean( squeeze(I2(ind1,ind2,:)) );
        end
    end
end
figure(4);  imshow(uint8(I2));

%% Make the gray color cyan in the Shindler's List effect image
[M N C] = size(I);
color_center = [255 0 0];
color_rad = 100;
I2 = double(I);
for ind1 = 1:M
    for ind2 = 1:N
        if sqrt(sum( (squeeze( I2(ind1, ind2, :))' - color_center).^2 ) ) > color_rad
            I2(ind1,ind2,1) = 0.6*mean( squeeze(I2(ind1,ind2,:)) ); % Pronounce green and blue, reduce red , sum to one 
            I2(ind1,ind2,2) = 1.2*mean( squeeze(I2(ind1,ind2,:)) ); % Pronounce green and blue, reduce red 
            I2(ind1,ind2,3) = 1.2*mean( squeeze(I2(ind1,ind2,:)) ); % Pronounce green and blue, reduce red 
        end
    end
end
figure(4);  imshow(uint8(I2));


%% Darken the parrot
I2 = double(I);
x = 0.8;

I2(:,:,1) = I2(:,:,1).^x;
I2(:,:,2) = I2(:,:,2).^x;
I2(:,:,3) = I2(:,:,3).^x;

figure(5); imshow(uint8(I2));

%% Brighten the parrot
I2 = double(I);
x = 1.2;

I2(:,:,1) = I2(:,:,1).^x;
I2(:,:,2) = I2(:,:,2).^x;
I2(:,:,3) = I2(:,:,3).^x;

figure(6); imshow(uint8(I2));

%% Complement the parrot
I2 = I;

I2(:,:,1) = 255 - I2(:,:,1);
I2(:,:,2) = 255 - I2(:,:,2);
I2(:,:,3) = 255 - I2(:,:,3);

figure(7); imshow(I2);

%% Histogram equalize the parrot
JR = histeq(I(:,:,1), 64);
JG = histeq(I(:,:,2), 64);
JB = histeq(I(:,:,3), 64);

I_eq = I;
I_eq(:,:,1) = JR;
I_eq(:,:,2) = JG;
I_eq(:,:,3) = JB;
f5 = figure(5); set(f5,'Position', [100 100 1600 800]);
subplot(3,2,[1 3 5]); imshow(I); title('Original Parrot','FontWeight','Demi','FontSize',12);
subplot 322; temp = I(:,:,1); stem(hist(double( temp(:) ), 255 )); title('Red Channel Histogram','FontWeight','Demi','FontSize',12);    xlim([0 255]);
subplot 324; temp = I(:,:,1); stem(hist(double( temp(:) ), 255 )); title('Green Channel Histogram','FontWeight','Demi','FontSize',12);  xlim([0 255]);
subplot 326; temp = I(:,:,1); stem(hist(double( temp(:) ), 255 )); title('Blue Channel Histogram','FontWeight','Demi','FontSize',12);   xlim([0 255]);

f4 = figure(6);  set(f4,'Position', [200 200 1600 800]);
subplot(3,2,[1 3 5]); imshow(I_eq); title('Histogram Equalized Parrot','FontWeight','Demi','FontSize',12);
subplot 322; stem(hist(double(JR(:) ), 255 )); title('Red Channel Histogram','FontWeight','Demi','FontSize',12);    xlim([0 255]);
subplot 324; stem(hist(double(JB(:) ), 255 )); title('Green Channel Histogram','FontWeight','Demi','FontSize',12);  xlim([0 255]);
subplot 326; stem(hist(double(JG(:) ), 255 )); title('Blue Channel Histogram','FontWeight','Demi','FontSize',12);   xlim([0 255]);