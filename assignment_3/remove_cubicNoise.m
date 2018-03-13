function [ newImg ] = remove_cubicNoise( img )
%REMOVE_CUBICNOISE Summary of this function goes here
%   Detailed explanation goes here
    
    f = fft2(img);
    f_shifted = fftshift(f);
    
    fabs = abs(log(f_shifted));
    
    thresh = 10.5;
    brightSpikes = fabs > thresh;
    
%     imshow(brightSpikes); title('bright spikes'); axis on;
 
    filter = ones(512,512);
    
    for x = 237:277
        y = round((-13*x+7710)/17);
        filter(x,y-3:y+3) = 0;
    end
    
    filter(256:258,256:258) = 1;
    
    filter(257,253) = 0;
    filter(257,261) = 0;
    
    newImg = f_shifted .* filter;
    
%     imshow(log(abs(newImg))); title('removed spikes'); axis on;
    
    
    newImg = uint8(ifft2(ifftshift(newImg)));

end

