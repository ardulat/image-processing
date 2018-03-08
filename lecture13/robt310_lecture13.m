%% ROBT 310 - Lecture 13 - Filtering in the Frequency Domain Matlab Codes
%

clc; clear; close all; % Clear the environment

%% Spatial Domain Sobel Filter

%Create the Spacial Filtered Image
I = imread('skyline.jpg');
I = rgb2gray(I);
I = I(1:800, 1:800);    
h = fspecial('sobel');
I_sobel = imfilter(double(I), h, 0, 'conv');

%Display results (show all values)
figure(1); imshow(I);
figure(2); imshow(I_sobel);
title('Spatial Domain Sobel Filtered Image',...
      'FontWeight','Demi')

%% Frequency Domain Implementation of the Sobel Filter

F = fft2(double(I));
H = fft2(double(h), 800, 800);
F_sobel = H.*F;
I_sobel2 = ifft2(F_sobel);

%Display results (show all values)
figure(3); imshow(I_sobel2); 
title('Frequncy Domain Sobel Filtered Image','FontWeight','Demi')

%% Frequency Domain Specific Filter

%Create a Ideal Lowpass with cutoff 500
D0 = 1500;
H = lpfilter('ideal', 800, 800, D0);

% Calculate the discrete Fourier transform of the image
F = fft2(double(I), size(H,1), size(H,2));

% Apply the lowpass filter to the Fourier spectrum of the image
LPF_F = H.*F;

% convert the result to the spacial domain.
LPF_I = real(ifft2(LPF_F)); 

% Crop the image to undo padding
LPF_I = LPF_I (1: size(I,1), 1:size(I,2));
LPF_I = 255*(LPF_I - min(LPF_I(:))) / ( max(LPF_I(:))  - min(LPF_I(:)) ); % Normalize

%Display the blurred image
figure(4); imshow(uint8(LPF_I))

% Display the fftshifted 2D FFT of the image
F_norm = abs(fftshift(F));
F_norm = (F_norm - min(F_norm(:)))/( max(F_norm(:)) - min(F_norm(:))); % Normalize
F_log = F_norm.^(0.2);
figure(5); imshow( uint8(255*F_log)  );

%% Add sinusoidal noise
I_noise = I;
for ind1 = 1:1600
    for ind2 = 1:1600
    % I_noise(ind1, ind2) =  80*sin( 0.05*(ind1) ) + 70*sin(0.5*ind2) ;
    I_noise(ind1, ind2) =  150*sin( 0.1*(ind1) );
    end
end
I_noise = imrotate(I_noise,45,'crop');
I_noise = I_noise(401:1200, 401:1200);
figure(6); imshow(uint8(I_noise) );

% Display the fftshifted 2D FFT of the image
F = fft2(double(I_noise) );
F_norm = abs(fftshift(F));
F_norm = (F_norm - min(F_norm(:)))/( max(F_norm(:)) - min(F_norm(:))); % Normalize
F_log = F_norm.^(0.1);
figure(7); imshow( uint8(255*F_log)  );

% Look at the 2D FFT as a 3D plot
[x, y] = meshgrid(1:800, 1:800);
figure(8); surf(F_norm(351:450, 351:450) ); % Show the central freqs
