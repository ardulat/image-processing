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

imshow(img,img_ref);

%% Scale image
c_x = 0.5;
c_y = 1.5;
newImg = zeros(c_x*imgSize(1), c_y*imgSize(2),'uint8');

for i = 1:imgSize(1)
    for j = 1:imgSize(2)
        i_dash = uint32(i*c_x);
        j_dash = uint32(j*c_y);
        st_i = uint32((i-1)*c_x+1);
        st_j = uint32((j-1)*c_y+1);
        newImg(st_i:i_dash,st_j:j_dash) = img(i,j);
    end
end

newImg_ref = imref2d(size(newImg));
subplot(121);
imshow(img, img_ref);
subplot(122);
imshow(newImg, newImg_ref);

%% Rotate image
theta = pi/4;
newImg = zeros(uint32(2*imgSize(1)*cos(theta)),uint32(2*imgSize(2)*sin(theta)),'uint8');
mid_x = round(imgSize(1)*cos(theta));
mid_y = round(imgSize(2)*sin(theta));

for i = 1:imgSize(1)
    for j = 1:imgSize(2)
        i_dash = (i-mid_y)*cos(theta)+(j-mid_x)*sin(theta);
        j_dash = (i-mid_y)*cos(theta)-(j-mid_x)*sin(theta);
        i_dash = round(i_dash)+mid_x;
        j_dash = round(j_dash)+mid_y;
%         fprintf('x: %d\ny: %d\n---------\n',i_dash,j_dash);
        if(i_dash>=1 && j_dash>=1 && i_dash<=imgSize(1) && j_dash<=imgSize(2))
            newImg(i_dash,j_dash) = img(i,j);
        end
    end
end

newImg_ref = imref2d(size(newImg));
subplot(121);
imshow(img,img_ref);
subplot(122);
imshow(newImg,newImg_ref);

%% Translate image
t_x = 100;
t_y = 100;
newImg = zeros(imgSize(1)+t_x,imgSize(2)+t_y,'uint8');

for i = 1:imgSize(1)
    for j = 1:imgSize(2)
        i_dash = i+t_x;
        j_dash = j+t_y;
        newImg(i_dash,j_dash) = img(i,j);
    end
end

newImg_ref = imref2d(size(newImg));
subplot(121);
imshow(img, img_ref);
subplot(122);
imshow(newImg,newImg_ref);

%% Sheer (Vertical)
s_v = 0.5;
newImg = zeros(imgSize(1)+s_v*imgSize(2),imgSize(2),'uint8');

for i = 1:imgSize(1)
    for j = 1:imgSize(2)
        i_dash = uint32(i+s_v*j);
        j_dash = j;
        newImg(i_dash,j_dash) = img(i,j);
    end
end

newImg_ref = imref2d(size(newImg));
subplot(121);
imshow(img,img_ref);
subplot(122);
imshow(newImg,newImg_ref);

%% Sheer (Horizontal)
s_h = 0.5;
newImg = zeros(imgSize(1),imgSize(2)+s_h*imgSize(1),'uint8');

for i = 1:imgSize(1)
    for j = 1:imgSize(2)
        i_dash = i;
        j_dash = uint32(j+s_h*i);
        newImg(i_dash,j_dash) = img(i,j);
    end
end

newImg_ref = imref2d(size(newImg));
subplot(121);
imshow(img,img_ref);
subplot(122);
imshow(newImg,newImg_ref);
