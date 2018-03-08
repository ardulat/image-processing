% ROBT 310 - Project 3
%
% Author: Anuar Maratkhan
% Date: 1 March 2018

close all ; clc; clear;

%% accomplished task
vid = VideoReader('robt310_proj3_expert_amaratkhan.avi');
frames = vid.NumberOfFrames;

output = VideoWriter('result.avi');
open(output);

% process the video
for i = 1:frames
   img = read(vid,i);
   img(:,:,1) = medfilt2(img(:,:,1));
   img(:,:,2) = medfilt2(img(:,:,2));
   img(:,:,3) = medfilt2(img(:,:,3));
   
   img(:,:,1) = frequency_noise(img(:,:,1));
   img(:,:,2) = frequency_noise(img(:,:,2));
   img(:,:,3) = frequency_noise(img(:,:,3));
   
   writeVideo(output,img);
end

close(output);

implay('result.avi');

%% development process
close all; clear;

vid = VideoReader('robt310_proj3_expert_amaratkhan.avi');
img = readFrame(vid);

% median filter
gray = rgb2gray(img);
median = medfilt2(gray);

% Fourier transform
f = fft2(median);

% remove spikes
f_shifted = fftshift(f);
% figure(9); imshow(f_shifted,[]); axis on;

% good representation of frequency domain
representation = log(abs(f_shifted));
% representation(224,242) = 0;
% representation(290,272) = 0;
figure(10); imshow(representation,[]); axis on; title('Frequency domain');

% thresholding (DC + spikes)
thresh = 10.9;
brightSpikes = representation > thresh;
figure(11); imshow(brightSpikes); axis on; title('Bright spikes with DC component');

% brightSpikes(:,251:263) = 0;
brightSpikes(:,:) = 0;
% high spikes
brightSpikes(247:251,239:243) = 1;
brightSpikes(251:255,247:251) = 1;
brightSpikes(259:263,263:267) = 1;
brightSpikes(263:267,271:275) = 1;
% low spikes
brightSpikes(240:244,222:226) = 1;
brightSpikes(270:274,288:292) = 1;
brightSpikes(278:282,304:308) = 1;
% doubtful spikes
brightSpikes(253,245) = 1;
brightSpikes(253,246) = 1;
brightSpikes(254,245) = 1;

brightSpikes(261,268) = 1;
brightSpikes(261,269) = 1;
brightSpikes(260,269) = 1;

% smallest spikes
brightSpikes(240:244,222:226) = 1;
brightSpikes(270:274,288:292) = 1;


figure(12); imshow(brightSpikes); axis on; title('Bright spikes without DC component');

brightSpikes = 1 - brightSpikes;
f_shifted = f_shifted.*brightSpikes;
figure(13); imshow(log(abs(f_shifted)),[]); axis on; title('Filtered');

% results
f = ifftshift(f_shifted);
filteredImage = uint8(ifft2(f));
figure(21); imshowpair(median, filteredImage, 'montage');

fabs = 100*log(1+abs(fftshift(f)));

figure(42); mesh(fabs);






