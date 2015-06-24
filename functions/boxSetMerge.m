function [boxSetOutput, didMergeBoxes, varargout] = boxSetMerge(boxSet, varargin)
%boxSetMerge merges objects
%   [boxSet, didMergeBoxes] = boxSetMerge(boxSet)
%
%   [boxSet, didMergeBoxes] = boxSetMerge(boxSet, activeBoxes)
%
%   [boxSet, didMergeBoxes, activeBoxes] = boxSetMerge(boxSet, activeBoxes)

% jd, May 2015


%% Function input

numBoxes = length(boxSet);

if nargin > 1
    activeBoxes = varargin{1};
    keepOriginalSetSize = true;
else
    activeBoxes = ones(1, numBoxes);
    keepOriginalSetSize = false;
end

if nargin >= 3
    
    minMergeIntersectionRatio = varargin{2};
    
else
    
    minMergeIntersectionRatio = 0.33;
    
end


%% 

didMergeBoxes = zeros(1,numBoxes);

markedForDiscarding = zeros(1,numBoxes);

% Start with input box set
boxSetOutput = boxSet;

for i = 1:numBoxes
    for j = (i+1):numBoxes
        
        if activeBoxes(i) && activeBoxes(j)
            
            [compMatrix_ij, b1Area, b2Area, intersectionArea] = boxSimilarityIndex(...
                boxSet{i}, boxSet{j});


            % ----------------------------------------------------------------
            % Merging rule: 1) Merge boxes according to intersection/Dice
            % And possibly: 2) Provided the labels are close to each other
            %               3) And with similar texture (e.g. stdev?)

            % Meaningful values if 0 < minMergeIntersectionRatio < 1
            % 0 or below means no intersection allowed
            % 1 or above means test for same-object
%             minMergeIntersectionRatio = 0.33;

            if (intersectionArea >= minMergeIntersectionRatio * b1Area) ...
                || (intersectionArea >= minMergeIntersectionRatio * b2Area)

                % grow box1
                % Position of new rect is min of both
                % Size of new rect is max of both minus Position
                boxSetOutput{i} = boxMerge(boxSet{i}, boxSet{j});
                didMergeBoxes(i) = j;

                % discard box2
                markedForDiscarding(j) = 1;
                activeBoxes(j) = 0;


            end
            
        end        
    end
end

% ----------------
% Problem:
% Need to know the indexes of boxes that were removed. It's the only way to
% deleted corresponding labels!

if ~keepOriginalSetSize
    
    i = 1;

    % Make sure it's a column:
    markedForDiscarding = markedForDiscarding(:);

    while i < numBoxes

        if markedForDiscarding(i)

            % Remove element i and update num of boxes
            boxSetOutput = {boxSetOutput{1:i-1}, boxSetOutput{i+1:end}};
            markedForDiscarding = [markedForDiscarding(1:i-1); markedForDiscarding(i+1:end)];

            numBoxes = numBoxes - 1;

        else

            i = i + 1;
        end

    end

end

if nargout > 2
    
    varargout{1} = activeBoxes;
    
end


function minContainerBox = boxMerge(box1, box2)
% grow box
% Position of new rect is min of both
% Size of new rect is max of both minus Position

minContainerBox = min(box1(1:2), box2(1:2));

maxOppositeCorner = max(box1(1:2) + box1(3:4), box2(1:2) + box2(3:4));

minContainerBox(3:4) = maxOppositeCorner - minContainerBox;


