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
    thresh = 10.5;
    brightSpikes = representation > thresh;
    
    sharedSpikes = sharedSpikes .* brightSpikes;
    imshow(sharedSpikes);

    f_shifted = f_shifted.*brightSpikes;

    % results
    f = ifftshift(f_shifted);
    filteredImage = uint8(ifft2(f));

end

