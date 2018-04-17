function [ newImg ] = create_mosaic( filename, path, recSize, shape )
%CREATE_MOSAIC The method converts an image to a mosaic of images from 
% the dataset with shape of given size
%   Input:
%       filename = string name of image to be converted
%       path = string path to the dataset of images to be used for mosaic
%       recSize = integer size of mosaic batches
%       shape = shape of batches ('rectangular' or 'circular')
%   Output:
%       newImg = final image converted to the mosaic

    % load images
    dir_name = path; % 'database'
    list_jpg = dir([dir_name '/*.jpg']);
    list_png = dir([dir_name '/*.png']);

    list_img = horzcat(list_jpg', list_png');
    for i = 1:length(list_img)
        imageName = list_img(i).name;
        images{i} = imread([dir_name '/' imageName]);
    end

    % computing average RGB
    for i = 1:length(images)
        image = imresize(images{i}, [100 NaN]);
        images{i} = image;

        r = mean2(image(:,:,1));
        g = mean2(image(:,:,2));
        b = mean2(image(:,:,3));
        rgb = [r g b];
        averages{i} = rgb;
    end

    % choose target image
    img = imread(filename); % 'mandrill.png'
    % recSize = 16; - recSize provided
    fprintf('Okay, processing...\n');
    imgSize = size(img);
    ver_batches = floor(imgSize(1)/recSize);
    hor_batches = floor(imgSize(2)/recSize);
    total_batches = ver_batches*hor_batches;
    newSize = total_batches*recSize^2;
    start_col = 1;
    end_col = recSize;
    img_avg = ones(total_batches,3);
    index = 1;
    for i = 1:hor_batches
        start_row = 1;
        end_row = recSize;
        for j = 1:ver_batches
            subImage = img(start_row:end_row, start_col:end_col, :);
            r = mean2(subImage(:,:,1));
            g = mean2(subImage(:,:,2));
            b = mean2(subImage(:,:,3));
            img_avg(index, 1:3) = [r g b];
            index = index+1;
            start_row = start_row + recSize;
            end_row = end_row + recSize;
        end
        start_col = start_col + recSize;
        end_col = end_col + recSize;
    end

    img_avg_size = size(img_avg);

    % GENERATING COLOR BATCHES
    % img_avg = round(img_avg);
    % batches = zeros(total_batches, recSize, recSize, 3, 'uint8');
    % for i = 1:img_avg_size(1)
    %     for j = 1:img_avg_size(2)
    %         batches(i,:,:,j) = img_avg(i,j);
    %     end
    % end

    % generating rectangular image batches
    img_avg = round(img_avg);
    batches = ones(total_batches, recSize, recSize, 3, 'uint8');

    if(strcmp(shape,'rectangular'))
        for i = 1:img_avg_size(1)
            distances = 1:length(averages);
            for j = 1:length(averages)
                candidate_avg = [averages{j}];
                distances(j) = euclidean_distance(img_avg(i,:),candidate_avg);
            end
            [min_d, index_d] = min(distances);
            batch = cell2mat(images(index_d));
            batch = imresize(batch, [recSize recSize]);
            batches(i,:,:,:) = batch;
        end

    elseif(strcmp(shape,'circular'))
        for i = 1:img_avg_size(1)
            distances = 1:length(averages);
            for j = 1:length(averages)
                candidate_avg = [averages{j}];
                distances(j) = euclidean_distance(img_avg(i,:),candidate_avg);
            end
            [min_d,index_d] = min(distances);
            batch = cell2mat(images(index_d));
            batch_size = size(batch);
            % convert rectangular batch to circular
            img_mask1 = imread('circle.png');
            img_mask1 = imresize(img_mask1,[batch_size(1) batch_size(2)]);
            img_mask1_logical = logical(img_mask1);
            img_mask1_int = uint8(img_mask1_logical);
            batch_inner = batch.*img_mask1_int;

            img_mask2 = imread('circle complement.png');
            img_mask2 = imresize(img_mask2,[batch_size(1) batch_size(2)]);
            img_mask2_logical = logical(img_mask2);
            img_mask2_int = uint8(img_mask2_logical);
            target_color = ones(batch_size(1),batch_size(2),3,'uint8');
            % generate actual color
            target_color(:,:,1) = img_avg(i,1);
            target_color(:,:,2) = img_avg(i,2);
            target_color(:,:,3) = img_avg(i,3);

            batch_outer = target_color.*img_mask2_int;
            batch = batch_inner+batch_outer;

            batch = imresize(batch,[recSize recSize]);
            batches(i,:,:,:) = batch;
        end

    else % newline
        fprintf('Error: wrong input - shape. Please choose either "rectangular" or "circular"\n');
    end

    newImg = assemble_mosaic(batches, hor_batches, ver_batches);
    fprintf('Done!\n');

    if isequal(size(newImg),imgSize) ~= 1
        fprintf('Size of the image has changed.\n');
    end

end