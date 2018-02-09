function [ mosaic ] = assemble_mosaic( batches, hor_batches, ver_batches )
%ASSEMBLE_MOSAIC the method generates single RGB image (matrix) from an
% array of RGB image batches
%   Input:
%       batches = array of RGB image batches
%       hor_batches = number of horizontal batches in the image
%       ver_batches = number of vertical batches in the image
%   Output:
%       mosaic = final assembled RGB image

    batch_size = size(batches);
    horizontal = [];
    id = 1;

    for i = 1:hor_batches
        vertical = reshape(batches(id,:,:,:), [batch_size(2) batch_size(3) 3]);
        id = id+1;
        for j = 1:ver_batches-1
            reshaped_batch = reshape(batches(id,:,:,:), [batch_size(2) batch_size(3) 3]);
            id = id+1;
            vertical = cat(1, vertical, reshaped_batch);
        end
        horizontal = cat(2, horizontal, vertical);
    end

    mosaic = horizontal;

end

