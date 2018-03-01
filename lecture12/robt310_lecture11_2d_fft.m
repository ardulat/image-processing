% 2D FFT Example:


%% Rectangle 
close all; clear all;

I1 = imread('rectangle.tif','tif'); 
%I1 = imrotate(I1,45);
I2  = fftshift(I1);             % Shift Zero Freq to the Center of the Spectrum            
F  = fft2(I2);                  % Take the Fast Fourier Transform

f1 = figure(1); 
imshow(I1);
title('Original Image','FontWeight','Demi','FontSize',12);

f2 = figure(2);
imagesc(100*log(1+abs(fftshift(F)))); colormap(gray); 
title('Magnitude Spectrum','FontWeight','Demi','FontSize',12);

f4 = figure(3);
imagesc(angle(F));  colormap(gray);
title('Phase Spectrum','FontWeight','Demi','FontSize',12);

%% Blown Integrated Circuit
close all; clear; clc; 

I1 = imread('blown_ic.tif','tif'); 
I2  = fftshift(I1);                % Shift Zero Freq to the Center of the Spectrum            
F  = fft2(I2);                     % Take the Fast Fourier Transform

f1 = figure(1); 
imshow(I1);
title('Original Image','FontWeight','Demi','FontSize',12);

f2 = figure(2);
imagesc(100*log(1+abs(fftshift(F)))); colormap(gray); 
title('Magnitude Spectrum','FontWeight','Demi','FontSize',12);

f4 = figure(3);
imagesc(angle(F));  colormap(gray);
title('Phase Spectrum','FontWeight','Demi','FontSize',12);

% Reconstruct image from the F

I_reconst = fftshift( uint8( ifft2(F)) ); % Reconstruct using phase and magnitude
I_reconst_abs = fftshift( uint8( ifft2(abs(F))) );   % Reconstruct using 
% Reconstruct using phase
I_reconst_phase = fftshift(abs(ifft2( angle(F))));
I_reconst_phase = ( I_reconst_phase - min( I_reconst_phase(:) ) ) / ( max(I_reconst_phase(:)) - min(I_reconst_phase(:)) );
I_reconst_phase = 255*(I_reconst_phase.^0.2);
I_reconst_phase = uint8( I_reconst_phase );
I_reconst_phase = fftshift(I_reconst_phase);

figure(4);
subplot 131;
imshow( I_reconst );
title('Reconstructed Image','FontWeight','Demi','FontSize',12);
subplot 132;
imshow( I_reconst_abs );
title('Reconstructed Image using Magnitude oart of FFT','FontWeight','Demi','FontSize',12);
subplot 133;
imshow( I_reconst_phase );
title('Reconstructed Image using Phase oart of FFT','FontWeight','Demi','FontSize',12);


title('Original Image','FontWeight','Demi','FontSize',12);

f2 = figure(2);
imagesc(100*log(1+abs(fftshift(F)))); colormap(gray); 
title('Magnitude Spectrum','FontWeight','Demi','FontSize',12);