% load images
dir_name = 'logos';
list_jpg = dir([dir_name '/*.jpg']);
list_png = dir([dir_name '/*.png']);

list_img = horzcat(list_jpg', list_png');
for i = 1:length(list_img)
    imageName = list_img(i).name;
    disp(i);
    disp(imageName);
    images{i} = imread([dir_name '/' imageName]);
end

% computing average RGB
for i = 1:length(images)
    image = imresize(images{i}, [64 NaN]);
    disp(i);
    images{i} = image;
    disp(size(image));

    r = mean2(image(:,:,1));
    g = mean2(image(:,:,2));
    b = mean2(image(:,:,3));
    rgb = [r g b];
    averages{i} = rgb;
end

% choose target image
img = imread('mandrill.png');
numberOfTiles = 100;
imgSize = size(img);
numberOfPixels = imgSize(1)*imgSize(2);
subImagePixels = numberOfPixels/numberOfTiles;
recSize = sqrt(subImagePixels);
start_col = 1;
end_col = recSize;
img_avg = ones(numberOfTiles,3);
index = 1;
for i = 1:sqrt(numberOfTiles)
    start_row = 1;
    end_row = recSize;
    for j = 1:sqrt(numberOfTiles)
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

% generating color batches
% img_avg = round(img_avg);
% batches = zeros(numberOfTiles, recSize, recSize, 3, 'uint8');
img_avg_size = size(img_avg);
% for i = 1:img_avg_size(1)
%     for j = 1:img_avg_size(2)
%         batches(i,:,:,j) = img_avg(i,j);
%     end
% end

% generating image batches
img_avg = round(img_avg);
batches = ones(numberOfTiles, recSize, recSize, 3, 'uint8');
for i = 1:img_avg_size(1)
    for k = 1:img_avg_size(2)
        distances = 1:length(averages);
        for j = 1:length(averages)
            candidate_avg = [averages{j}];
            distances(j) = euclidean_distance(img_avg(i,:),candidate_avg);
        end
        [min_d, index_d] = min(distances);
        batch = cell2mat(images(index_d));
%         change resolution to [recSize X recSize]
        batch = imresize(batch, [48 48]);
        disp(size(batch));
        batches(i,:,:,:) = batch;
    end
end


newImg = assemble_mosaic(batches, imgSize(1)/recSize, imgSize(2)/recSize);

imshow([img,newImg]);
