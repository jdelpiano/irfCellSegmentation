% --- Auxiliary function for OME Tiff image opening.
function image = openOMETiffImage(imageFilename)

% Open OME Tiff
data = bfopen(imageFilename);

seriesCount = size(data, 1);

series1 = data{1, 1};

metadataList = data{1, 2};

series1_planeCount = size(series1, 1);
series1_plane1 = series1{1, 1};

% uint16 data here:
image = series1_plane1;

% Convert to double
% imgType = 'uint16';
image = im2double(image);  % /double(intmax(imgType));



