function [ newpixel ] = find_closest_palette_color( oldpixel, colors )
%FIND_CLOSEST_PALETTE_COLOR Finds closest intensity in different colormap
%   Input:
%       oldpixel - intensity of the old pixel
%       colors - number of colors in colormap
%   Output:
%       newpixel - intensity of the new pixel

    if colors <= 2
        colors = colors-1;
    end
    div = 256/colors;
    newpixel = (oldpixel/(div))*div;

end

