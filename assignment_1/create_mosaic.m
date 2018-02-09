function [ newImg ] = create_mosaic( filename, path, recSize, shape )
%CREATE_MOSAIC Summary of this function goes here
%   Detailed explanation goes here

tic; % start time
% load images
dir_name = path;
list_jpg = dir([dir_name '/*.jpg']);
list_png = dir([dir_name '/*.png']);

list_img = horzcat(list_jpg', list_png');
for i = 1:length(list_img)
    imageName = list_img(i).name;
    images{i} = imread([dir_name '/' imageName]);
end

% computing average RGB
for i = 1:length(images)
    image = imresize(images{i}, [64 NaN]);
    images{i} = image;

    r = mean2(image(:,:,1));
    g = mean2(image(:,:,2));
    b = mean2(image(:,:,3));
    rgb = [r g b];
    averages{i} = rgb;
end

% choose target image
img = imread(filename);
% recSize = input('Please enter a rectangle size: ');
fprintf('Okay, processing...\n');
% recSize = 16;
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
%         fprintf('hor=%d ver=%d\ti=%d j=%d\n', hor_batches, ver_batches, i, j);
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

% generating color batches
% img_avg = round(img_avg);
% batches = zeros(total_batches, recSize, recSize, 3, 'uint8');
% for i = 1:img_avg_size(1)
%     for j = 1:img_avg_size(2)
%         batches(i,:,:,j) = img_avg(i,j);
%     end
% end

% generating image batches
img_avg = round(img_avg);
batches = ones(total_batches, recSize, recSize, 3, 'uint8');
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

newImg = assemble_mosaic(batches, hor_batches, ver_batches);
fprintf('Done!\n');

if isequal(size(newImg),imgSize) ~= 1
    fprintf('Size of the image has changed.\n');
end

% subplot(121); imshow(img);
% subplot(122); imshow(newImg);
imshow(newImg);

toc % end time

end

