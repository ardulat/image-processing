function [ euc_dist ] = euclidean_distance( avg1, avg2 )
%EUCLIDEAN_DISTANCE The method calculates euclidean distance of two
% vectors
%   Input:
%       avg1 = first vector containing average RGB values
%       avg2 = second vector containing average RGB values
%   Output:
%       euc_dist = euclidean distance of provided vectors


    r = (avg1(1) - avg2(1))^2;
    g = (avg1(2) - avg2(2))^2;
    b = (avg1(3) - avg2(3))^2;

    euc_dist = sqrt(r+g+b);

end

