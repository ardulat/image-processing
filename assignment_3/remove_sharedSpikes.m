function [ newImg ] = remove_sharedSpikes( img )
%REMOVE_SHAREDSPIKES Summary of this function goes here
%   Detailed explanation goes here

    f = fft2(img);
    f_shifted = fftshift(f);
    
    fabs = abs(log(f_shifted));
%     figure(1); imshow(fabs,[]); title('Spikes present');
%     figure(11); mesh(fabs); title('Spikes present'); pause;
    
    mask = imread('shared.png');
    mask = logical(mask);
    
    filter = double(ones(size(img,1), size(img,2)));
    
%     for i = 1:size(mask,1)
%         for j = 1:size(mask,2)
%             if (mask(i,j) == 1)
%                 neighbors = fabs(i-10:i+10,j-10:j+10);
%                 indices = find(neighbors > 8.5);
%                 neighbors(indices) = NaN;
%                 avg = mean(neighbors(:),'omitnan');
% %                 filter(i,j) = (avg / max(fabs(:)));
%                 filter(i,j) = mean(fabs(:)) / max(fabs(:));
% %                 filter(i,j) = 0;
%                 fprintf('%f\n', filter(i,j));
%             end                            
%         end
%     end
    
    x = (mean(fabs(:)) / max(fabs(:)));
    x = 0;
    
    filter(234,208) = x;
    filter(241:242,224) = x;
    filter(249,237:242) = x;
    filter(247:251,241) = x;
    filter(248,240) = x;
    filter(250,239:240) = x;
    filter(253,246:252) = x;
    filter(248:255,249) = x;
    filter(250:254,250) = x;
    
    filter(280,306) = x;
    filter(272:273,290) = x;
    filter(265,272:277) = x;
    filter(263:267,273) = x;
    filter(266,274) = x;
    filter(264,274:275) = x;
    filter(259:266,265) = x;
    filter(261,262:268) = x;
    filter(260:264,264) = x;

    f_shifted = f_shifted .* filter;
    
%     figure(21); mesh(abs(log(f_shifted))); title('Spikes removed');
    
    fabs = abs(log(f_shifted));
    figure(2); imshow(fabs,[]); title('Spikes removed'); axis on;
%     figure(12); mesh(fabs); title('Spikes removed');
    
    f = ifftshift(f_shifted);
    newImg = uint8(ifft2(f));

end

