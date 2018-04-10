%% ROBT 310 - Lecture 20 - Basic Morphological Algorithms

clc; clear; close all; % Clear the environment


%% DEMO 0 - Hit or Miss Transformation - Find 54 x 54 white squares in the image.

% Firstly read the help file for the Matlab hit or miss trans
% implementation: bwhitmiss
% Then understand the code below
I = ~imread('hitmiss_demo.bmp');
[sx sy] =size(I);
figure(1); imshow(I); hold on;

sel1 = logical( ones(54,54) ) ;
sel2 = logical( ones(56,56) ) ;
sel2(2:end-1, 2:end-1) = 0;
I2 = bwhitmiss( I , sel1, sel2);
[y_ind x_ind] = find(I2 == 1);
plot( x_ind, y_ind, 'g.','MarkerSize',25);

% Modify the structural element such that the square with the circle inside
% is also detected.

%% DEMO 2 - Boundary Extraction
close all;
I = imread('lincoln.tif');
figure(1); imshow(I);
sel = ones(3,3);
I2 = abs(I - imerode(I, sel) );
figure(2); imshow(I2)

% Use different structural elements and comment on their effects

%% DEMO 3 - Region Filling - Iterative Application of Morph Operators

close all;
I = ~imread('regfill_demo.bmp');
figure(1); imshow(I); title('Please select a seed pixel');

% Enter the seed pixel
[y x] = ginput(1);
x = round(x); y = round(y);

sum_old = 0;    % Sum of all 1 pixels
count = 0;

sel = [ 0 1 0 ; 1 1 1 ; 0 1 0 ];
I2 = zeros(size(I)) ;
I2(x , y ) = 1;
while(1)
    
    I2 = imdilate(I2, sel) &  (~I);
    count = count + 1;
    figure(2);
    imshow(I2); title([ 'Iteration ' , num2str(count)] ); pause(0.005);
    
    temp = sum(I2(:));
    if (  temp == sum_old)
        break;
    end
    sum_old = temp;
end

% Find a simple method which will perform the task without seed pixels

%% DEMO 4 - Extraction of Connected Components

close all;
I = ~imread('regfill_demo.bmp');
figure(1); imshow(I); title('Please select a seed pixel');

% Enter the seed pixel
[y x] = ginput(1);
x = round(x); y = round(y);

sum_old = 0;    % Sum of all 1 pixels
count = 0;

sel = ones(3,3);
I2 = zeros(size(I)) ;
I2(x , y ) = 1;
while(1)
    
    I2 = imdilate(I2, sel) &  (I);
    count = count + 1;
    figure(2);
    imshow(I2); title([ 'Iteration ' , num2str(count)] ); pause(0.005);
    
    temp = sum(I2(:));
    if (  temp == sum_old)
        break;
    end
    sum_old = temp;
end

%% DEMO 5 - Convex Hull

close all; clear all; clc;

X = ~imread('concave_shape.bmp');
B{1} = ([1 0 0; 1 -1 0; 1 0 0]);
B{2} = ([1 1 1; 0 -1 0; 0 0 0]);
B{3} = ([0 0 1; 0 -1 1; 0 0 1]);
B{4} = ([0 0 0; 0 -1 0; 1 1 1]);

Xc{1} = X; Xc_old{1} = zeros( size(X) );
Xc{2} = X; Xc_old{2} = zeros( size(X) );
Xc{3} = X; Xc_old{3} = zeros( size(X) );
Xc{4} = X; Xc_old{4} = zeros( size(X) );

for ind = 1:4
    while(1)
        Xc{ind} = bwhitmiss( Xc{ind}, B{ind}) | Xc{ind};
        
        % Remove the frame artifacts
        temp = zeros(size(X)); 
        temp(2:end-1, 2:end-1) = Xc{ind}(2:end-1, 2:end-1);
        Xc{ind} = temp;
        
        if ( all(all(Xc{ind} == Xc_old{ind} )))
            break;
        end
        Xc_old{ind} = Xc{ind};
        
    imshow(Xc{1} | Xc{2} | Xc{3} | Xc{4});
    pause(0.005);
    end

end

I3 = Xc{1} | Xc{2} | Xc{3} | Xc{4};
imshow(I3 & ~X);
