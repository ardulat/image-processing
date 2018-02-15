% ROBT 310 - Lecture 9
%
% Author: Anuar Maratkhan
% Date: 15 Feb 2018

%%
clc; clear;
%% Shortcut version
I = imread('Fig0320(1)(top_left).tif');

newImg = histeq(I);

figure(1);
subplot(131); imshow(I); title('Original image');
subplot(132); imshow(newImg); title('Built-in function result');

%% Custom version

I = imread('Fig0320(1)(top_left).tif');

[rows cols] = size(I);
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

S = uint8(round(S));

newImg = I;
for i = 1:rows
    for j = 1:cols
        intensity = newImg(i,j);
        newImg(i,j) = S(intensity+1);
    end
end

subplot(133); imshow(newImg); title('Custom function result');
