function bw = cdfBasedThreshold(im, thresh)
%cdfBasedThreshold Convert image to binary by thresholding cdf
%   bw = cdfBasedThreshold(im, thresh) determines a graylevel threshold
%   such that all the pixels in image im which are over the value thresh of
%   the cumulative density function (cdf) will be one in the resulting
%   binary image bw
%
%   See also im2bw, ecdf

% jd, April 2015


[f,x] = ecdf(im(:));

id = find(f > thresh);

bw = im2bw(im, im2double(x(id(1))));



