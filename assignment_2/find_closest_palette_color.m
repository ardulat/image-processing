function [ newpixel ] = find_closest_palette_color( oldpixel, colors )
%FIND_CLOSEST_PALETTE_COLOR Summary of this function goes here
%   Detailed explanation goes here

colors = colors-1;
div = 256/colors;
newpixel = (oldpixel/(div))*div;

end

