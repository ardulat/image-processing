function [ ditheredImage ] = floyd_steinberg_dithering( newImg, colors )
%FLOYD_STERING_DITHERING Dithers image with Floyd-Steinberg diffusion
%   Input:
%       newImg - image to be dithered
%       colors - number of colors in colormap
%   Output:
%       ditheredImage - ditheredImage

    [rows, cols] = size(newImg);
    
    for i = 1:rows
        for j = 1:cols
            oldpixel = newImg(i,j);
            newpixel = find_closest_palette_color(oldpixel,colors);
            newImg(i,j) = newpixel;
            quant_error = oldpixel-newpixel*256;
            % neighbor pixels:
            if j+1 <= cols
                newImg(i,j+1) = newImg(i,j+1) + quant_error*7/16;
            end
            if i+1 <= rows
                if j-1 >= 1
                    newImg(i+1,j-1) = newImg(i+1,j-1) + quant_error*3/16;
                end
                newImg(i+1,j) = newImg(i+1,j) + quant_error*5/16;
                if j+1 <= cols
                    newImg(i+1,j+1) = newImg(i+1,j+1) + quant_error*1/16;
                end
            end
        end
    end

    ditheredImage = newImg;

end

