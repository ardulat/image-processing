function [ euc_dist ] = euclidean_distance( avg1, avg2 )
%EUCLIDEAN_DISTANCE Summary of this function goes here
%   Detailed explanation goes here


r = (avg1(1) - avg2(1))^2;
g = (avg1(2) - avg2(2))^2;
b = (avg1(3) - avg2(3))^2;

euc_dist = sqrt(r+g+b);

end

