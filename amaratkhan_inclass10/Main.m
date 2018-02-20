% ROBT 310 - Assignment 2
%
% Author: Anuar Maratkhan
% Date: 15 Feb 2018

I = imread('forest-green.jpg');
r = I(:,:,1);
g = I(:,:,2);
b = I(:,:,3);

I_1 = imread('forest-fire.jpg');
r_1 = I_1(:,:,1);
g_1 = I_1(:,:,2);
b_1 = I_1(:,:,3);

[r, sr] = hist_eq(r);
[g, sg] = hist_eq(g);
[b, sb] = hist_eq(b);
% I(:,:,1) = r;
% I(:,:,2) = g;
% I(:,:,3) = b;
% imshow(I);

[r_1, sr_1] = hist_eq(r_1);
[g_1, sg_1] = hist_eq(g_1);
[b_1, sb_1] = hist_eq(b_1);


[rows, cols, channels] = size(I);
[rows_1, cols_1, channels_1] = size(I_1);

inv_1 = zeros(1,256);
for i = 1:rows
    for j = 1:cols
        intensity = r(i,j);
        inverse = sr(intensity+1);
        inv_1(intensity+1) = inverse;
    end
end

for i = 1:rows_1
    for j = 1:cols_1
        intensity = r_1(i,j);
        r_1(i,j) = inv_1(intensity+1);
    end
end
% green
inv_1 = zeros(1,256);
for i = 1:rows
    for j = 1:cols
        intensity = g(i,j);
        inverse = sg(intensity+1);
        inv_1(intensity+1) = inverse;
    end
end

for i = 1:rows_1
    for j = 1:cols_1
        intensity = g_1(i,j);
        g_1(i,j) = inv_1(intensity+1);
    end
end
% blue
inv_1 = zeros(1,256);
for i = 1:rows
    for j = 1:cols
        intensity = b(i,j);
        inverse = sg(intensity+1);
        inv_1(intensity+1) = inverse;
    end
end

for i = 1:rows_1
    for j = 1:cols_1
        intensity = b_1(i,j);
        b_1(i,j) = inv_1(intensity+1);
    end
end

I_1(:,:,1) = r_1;
I_1(:,:,2) = g_1;
I_1(:,:,3) = b_1;
imshow(I_1);

function [newImg, S] = hist_eq(I)
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

    S = uint8(round(S));

    newImg = I;
    for i = 1:rows
        for j = 1:cols
            intensity = newImg(i,j);
            newImg(i,j) = S(intensity+1);
        end
    end
    
end

