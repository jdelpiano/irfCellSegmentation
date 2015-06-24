function [similarityIndex, varargout] = boxSimilarityIndex(box1, box2, varargin)
%boxSimilarityIndex Determines the similarity index between two rectangles
%   si = boxSimilarityIndex(box1, box2) determines the similarity index
%   between two bounding boxes. boxSimilarityIndex(box2, box1) yields the
%   same result.
%
%   si = boxSimilarityIndex(box1, box2, imSize) restricts the result to the
%   size of the image imSize
%
%   [si, b1Area, b2Area, intersectionArea] = boxSimilarityIndex(...)
%   returns more information about the bounding boxes

% jd, Feb-2015


if nargin > 2
    imSize = varargin{1};
else
    imSize = -1;
end


% Convert both bounding boxes to binary images
logical1 = rectToLogical(box1);
logical2 = rectToLogical(box2);
[m1, n1] = size(logical1);
[m2, n2] = size(logical2);

% Take both binary images to the same size

if imSize ~= -1
    logicalLargest = zeros(imSize);
    
%     [m, n] = size(im

else
    logicalLargest = zeros(max(size(logical1),size(logical2)));

end

aux = logical1;
logical1 = logicalLargest;

% Useful if image is smaller than resulting logical variable
if imSize ~= -1
    m1 = min(m1, imSize(1));
    n1 = min(n1, imSize(2));
end

% This should deal with more than one case: (size of logical1) ><= (size of
% image)
logical1(1:m1, 1:n1) = aux(1:m1, 1:n1);

aux = logical2;
logical2 = logicalLargest;

% Useful if image is smaller than resulting logical variable
if imSize ~= -1
    m2 = min(m2, imSize(1));
    n2 = min(n2, imSize(2));
end

% This should deal with more than one case: (size of logical2) ><= (size of
% image)
logical2(1:m2, 1:n2) = aux(1:m2, 1:n2);

% Find the similarity index
similarityIndex = 2 * sum( logical1(:) & logical2(:) ) ...
    / (sum(logical1(:)) + sum(logical2(:)));

% These should always be true:
% sum( logical1(:) & logical2(:) ) <= sum(logical1(:))
% sum( logical1(:) & logical2(:) ) <= sum(logical2(:))
%
% Idea:
% -----
% If one of these is very close to equality, suggest discarding box

if nargout>1
    
    if nargout ~= 4
        error('Not the right number of output variables.')
    end
    
    varargout{1} = sum(logical1(:));
    varargout{2} = sum(logical2(:));
    varargout{3} = sum(logical1(:) & logical2(:));
end


function logicalOutput = rectToLogical(rectInput)
% Converts rectangle data in the form [x y w h] to a binary image where
% pixels inside the rect are 1. The rest of the pixels have 0's.

intExRect = int16(rectInput);

x1 = intExRect(1);
y1 = intExRect(2);
x2 = x1 + intExRect(3);
y2 = y1 + intExRect(4);

x1 = max(1, x1);
y1 = max(1, y1);

logicalOutput = zeros(y2, x2);

logicalOutput(y1:y2,x1:x2) = 1;



%%