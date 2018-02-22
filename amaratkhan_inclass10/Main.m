% ROBT 310 - Lecture 10
%
% Author: Anuar Maratkhan
% Date: 15 Feb 2018

close all; clc; clear;

% processing
img1 = imread('forest-green.jpg');
newImg1 = img1;
r1 = img1(:,:,1);
g1 = img1(:,:,2);
b1 = img1(:,:,3);

img2 = imread('forest-fire.jpg');
newImg2 = img2;
r2 = img2(:,:,1);
g2 = img2(:,:,2);
b2 = img2(:,:,3);

% histogram matching: 1 -> 2
r1_matched = histogram_matching(r2,r1);
g1_matched = histogram_matching(g2,g1);
b1_matched = histogram_matching(b2,b1);

newImg3 = img1;
newImg3(:,:,1) = r1_matched;
newImg3(:,:,2) = g1_matched;
newImg3(:,:,3) = b1_matched;

% histogram matching: 2 -> 1

r2_matched = histogram_matching(r1,r2);
g2_matched = histogram_matching(g1,g2);
b2_matched = histogram_matching(b1,b2);

newImg4 = img2;
newImg4(:,:,1) = r2_matched;
newImg4(:,:,2) = g2_matched;
newImg4(:,:,3) = b2_matched;

% visualize
subplot(221); imshow(newImg1);
subplot(222); imshow(newImg2);
subplot(223); imshow(newImg3);
subplot(224); imshow(newImg4);

function [newImg, S] = histogram_equalization(I)
    [rows, cols] = size(I);
    MN = rows*cols;
    L = 256;

    N_k = zeros(L);

    for i = 1:rows
        for j = 1:cols
            id = I(i,j)+1;
            N_k(id) = N_k(id)+1;
        end
    end

    P_r = zeros(L);
    for i = 1:L
        P_r(i) = N_k(i)/MN;
    end

    cdf = zeros(L);
    cdf(1) = P_r(1);
    for i = 2:L
        cdf(i) = P_r(i) + cdf(i-1);
    end

    S = zeros(L);
    for i = 1:L
        S(i) = (L-1)*cdf(i);
    end

    newImg = I;
    for i = 1:rows
        for j = 1:cols
            intensity = newImg(i,j);
            newImg(i,j) = uint8(round(S(intensity+1)));
        end
    end
end

function newImg = histogram_matching(img1, img2)
    [~, S1] = histogram_equalization(img1);
    [~, S2] = histogram_equalization(img2);
    
    L = 256;
    newImg = img2;
    
    for i = 1:size(newImg,1)
        for j = 1:size(newImg,2)
            distances = zeros(L,1);
            for ind = 1:L
                intensity1 = double(S2(newImg(i,j)+1));
                intensity2 = double(S1(ind));
                euc_dist = sqrt(abs(intensity1^2-intensity2^2));
%                 euc_dist = abs(intensity1-intensity2);
                distances(ind) = euc_dist;
            end
            [~, index] = min(distances);
            newImg(i,j) = index-1;
        end
    end
end