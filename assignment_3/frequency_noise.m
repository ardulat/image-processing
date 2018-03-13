function [ filteredImage, sharedSpikes ] = frequency_noise( median, sharedSpikes )
%FREQUENCY_NOISE Summary of this function goes here
%   Detailed explanation goes here

    % Fourier transform
    f = fft2(median);

    % remove spikes
    f_shifted = fftshift(f);

    % good representation of frequency domain
    representation = log(abs(f_shifted));

    % thresholding (DC + spikes)
    thresh = 9.5;
    brightSpikes = representation > thresh;
    
    brightSpikes(256:259,256:259) = 0;
    
%     imshow(brightSpikes);
    
    sharedSpikes = sharedSpikes .* brightSpikes;
    imshow(sharedSpikes);

%     brightSpikes(:,:) = 0;
%     % high spikes
%     brightSpikes(247:251,239:243) = 1;
%     brightSpikes(251:255,247:251) = 1;
%     brightSpikes(259:263,263:267) = 1;
%     brightSpikes(263:267,271:275) = 1;
%     % low spikes
%     brightSpikes(240:244,222:226) = 1;
%     brightSpikes(270:274,288:292) = 1;
%     brightSpikes(278:282,304:308) = 1;
%     % doubtful spikes
%     brightSpikes(253,245) = 1;
%     brightSpikes(253,246) = 1;
%     brightSpikes(254,245) = 1;
% 
%     brightSpikes(261,268) = 1;
%     brightSpikes(261,269) = 1;
%     brightSpikes(260,269) = 1;
% 
%     % smallest spikes
%     brightSpikes(240:244,222:226) = 1;
%     brightSpikes(270:274,288:292) = 1;
% % 
%     brightSpikes = 1 - brightSpikes;
    
%     brightSpikes = imread('mask.png');
%     brightSpikes = logical(brightSpikes);
    f_shifted = f_shifted.*brightSpikes;

    % results
    f = ifftshift(f_shifted);
    filteredImage = uint8(ifft2(f));

end

