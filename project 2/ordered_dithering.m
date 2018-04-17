function [ newImg ] = ordered_dithering( img )
%ORDERED_DITHERING Ordered dithering according to Bayer's method (dispersed dots)
%   Input:
%       img - image to be dithered
%   Output:
%       newImg - dithered image

    H = [1 9 3 11;
        13 5 15 7;
        4 12 2 10;
        16 8 14 16];

    [rows, cols] = size(img);
    [hrows, hcols] = size(H);

    num_ver = floor(rows/hrows); % number of vertical H matrices
    num_hor = floor(cols/hcols); % number of horizontal H matrices

    n = num_hor*hcols;
    m = num_ver*hrows;

    newImg = double(img(1:m, 1:n));

    if size(img) ~= size(newImg)
        fprintf('The size of the image has changed.\n');
    end

    for i = 1:4:m
        for j = 1:4:n
            newImg(i:i+3,j:j+3) = newImg(i:i+3,j:j+3) + 16*H;
        end
    end

    newImg = uint8(255*(newImg > 255));

end

