function [ ditheredImage ] = robt310_project2_dither( input_file_name, ...
                                                      output_file_name, ...
                                                      part )
%ROBT310_PROJECT2_DITHER Dither input image according to provided method of
%dithering and save the dithered image to output file
%   Input:
%       input_file_name - name of input image (String)
%       output_file_name - name of the output image (String)
%       part - part of the task (e.g. 1, 2, 3) (Integer)
%   Output:
%       ditheredImage - dithered image

    % reading input image
    I = imread(input_file_name);

    % first part
    if part == 1
        I = rgb2gray(I);
        % image enhancement
        I = histeq(I);
        newImg = I;
        ditheredImage = floyd_steinberg_dithering(newImg,2);
        
    % second part    
    elseif part == 2

        r = histeq(I(:,:,1));
        g = histeq(I(:,:,2));
        b = histeq(I(:,:,3));

        newImg = I;

        r = floyd_steinberg_dithering(r,8);
        g = floyd_steinberg_dithering(g,8);
        b = floyd_steinberg_dithering(b,8);

        newImg(:,:,1) = r;
        newImg(:,:,2) = g;
        newImg(:,:,3) = b;
        
        ditheredImage = newImg;
        
    % third part
    elseif part == 3
        I = rgb2gray(I);
        I = histeq(I);
        ditheredImage = ordered_dithering(I);
    % easter egg
    elseif part == 42
        I = rgb2gray(I);
        I = histeq(I);
        orderedImage = ordered_dithering(I);
        ditheredImage = floyd_steinberg_dithering(orderedImage,2);
    else
        fprintf('Error: wrong input for ''part''\n');
        return;
    end

    % save figure to output file
    imwrite(ditheredImage, output_file_name);
    
end

