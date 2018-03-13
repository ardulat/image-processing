function [ newImg ] = remove_sharedSpikes( img )
%REMOVE_SHAREDSPIKES Summary of this function goes here
%   Detailed explanation goes here

    f = fft2(img);
    f_shifted = fftshift(f);
    
    mask = imread('shared.png');
    mask = logical(mask);
    
    mask(234,208) = 1;
    mask(280,306) = 1;
    
    mask = 1 - mask;
    
    f_shifted = f_shifted .* mask;
    
    f = ifftshift(f_shifted);
    newImg = uint8(ifft2(f));

end

