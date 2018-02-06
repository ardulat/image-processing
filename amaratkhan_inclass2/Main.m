% ROBT 310 - Lecture 8 Inclass exercise
%
% Author: Anuar Maratkhan
% Date: 6 Feb 2018

%%
close all ; clc; clear;     % Close all figure windows, Clear the screen and the workspace memory

%% Construct image
img = ones(500,500,'uint8')*255;
imgSize = size(img);
img = insertText(img,[imgSize(1)/2-5*72/2 imgSize(2)/2-72],'ANUAR','FontSize',72,...
    'BoxColor','white');
img_ref = imref2d(imgSize);

%% Scale image
c_x = 0.5;
c_y = 1.5;
scaled = zeros(c_x*imgSize(1), c_y*imgSize(2),'uint8');

for i = 1:imgSize(1)
    for j = 1:imgSize(2)
        i_dash = uint32(i*c_x);
        j_dash = uint32(j*c_y);
        st_i = uint32((i-1)*c_x+1);
        st_j = uint32((j-1)*c_y+1);
        scaled(st_i:i_dash,st_j:j_dash) = img(i,j);
    end
end

scaled_ref = imref2d(size(scaled));

%% Rotate image
theta = pi/6;
rotated = zeros(round(imgSize(1)*abs(cos(theta))),round(imgSize(2)*abs(sin(theta))),'uint8');
inds = zeros(imgSize(1),imgSize(2),2);

for i = 1:imgSize(1)
    for j = 1:imgSize(2)
        i_dash = round(i*cos(theta)+j*sin(theta));
        j_dash = round(-i*sin(theta)+j*cos(theta));
        inds(i,j,1) = i_dash;
        inds(i,j,2) = j_dash;
    end
end

minimal = min(min(min(inds)));
inds(:,:,2) = inds(:,:,2)-minimal+1;

for i = 1:imgSize(1)
    for j = 1:imgSize(2)
        i_dash = inds(i,j,1);
        j_dash = inds(i,j,2);
        rotated(i_dash,j_dash) = img(i,j);
    end
end

rotated = medfilt2(rotated);
rotated_ref = imref2d(size(rotated));

%% Translate image
t_x = 100;
t_y = 100;
translated = zeros(imgSize(1)+t_x,imgSize(2)+t_y,'uint8');

for i = 1:imgSize(1)
    for j = 1:imgSize(2)
        i_dash = i+t_x;
        j_dash = j+t_y;
        translated(i_dash,j_dash) = img(i,j);
    end
end

translated_ref = imref2d(size(translated));

%% Sheer (Vertical)
s_v = 0.5;
vertical = zeros(imgSize(1)+s_v*imgSize(2),imgSize(2),'uint8');

for i = 1:imgSize(1)
    for j = 1:imgSize(2)
        i_dash = uint32(i+s_v*j);
        j_dash = j;
        vertical(i_dash,j_dash) = img(i,j);
    end
end

vertical_ref = imref2d(size(vertical));

%% Sheer (Horizontal)
s_h = 0.5;
horizontal = zeros(imgSize(1),imgSize(2)+s_h*imgSize(1),'uint8');

for i = 1:imgSize(1)
    for j = 1:imgSize(2)
        i_dash = i;
        j_dash = uint32(j+s_h*i);
        horizontal(i_dash,j_dash) = img(i,j);
    end
end

horizontal_ref = imref2d(size(horizontal));

%% Display images on one figure

subplot(231); imshow(img,img_ref); title('Original');
subplot(232); imshow(scaled,scaled_ref); title('Scaling');
subplot(233); imshow(rotated,rotated_ref); title('Rotation');
subplot(234); imshow(translated,translated_ref); title('Translation');
subplot(235); imshow(vertical,vertical_ref); title('Sheer (Vertical)');
subplot(236); imshow(horizontal,horizontal_ref); title('Sheer (Horizontal)');
