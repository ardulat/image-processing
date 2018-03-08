function [H,D] = lpfilter(type,M,N,DO,n) 
% 
%  H = lpfilter(type,M,N,DO,n) 
%  TYPE, DO, and n: 
%  'ideal'     DO must be positive, n need not be supplied. 
%  'btw'       DO must be positive, the default value for n is 1.0. 
%  'gaussian'  DO must be positive, n need not be supplied. 
% 
 
[U,V] = dftuv(M,N); 
D = sqrt(U.^2+V.^2); 
switch type 
    case 'ideal' 
        H = double(D <= DO); 
    case 'btw' 
        if nargin == 4 
            n = 1; 
        end 
        H = 1./(1+(D./DO).^(2*n)); 
    case 'gaussian' 
        H = exp(-(D.^2)./(2*(DO^2))); 
    otherwise 
        error('Unknown filter type.') 
end