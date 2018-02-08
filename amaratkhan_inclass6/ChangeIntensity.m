function [ newImage ] = ChangeIntensity( image, intensityLevel )
%CHANGEINTENSITY Summary of this function goes here
%   Detailed explanation goes here


threshold = fix(255/intensityLevel);
numberOfThresholds = 255/threshold;

newImage = image;
current = threshold;
prev = 0;
next = threshold*2;
for t = 1:numberOfThresholds-1
    for i = 1:size(newImage,1)
        for j = 1:size(newImage,2)
            if newImage(i,j) < current && newImage(i,j) > prev
                newImage(i,j) = prev;
            end
        end
    end
    prev = current;
    next = next+threshold;
    current = current+threshold;
end
next = next-1;
for i = 1:size(newImage,1)
    for j = 1:size(newImage,2)
        if newImage(i,j) > prev
            newImage(i,j) = next;
        end
    end
end

end

