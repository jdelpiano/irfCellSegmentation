function result = laplacianOfGaussian(image, sigma)

imFilter = -fspecial('log', round(6 * sigma), sigma);

zeroMeanImage = double(image) - mean(image(:));
result = imfilter(zeroMeanImage, imFilter);

imMax = max(result(:));
imMin = min(result(:));
result = (result - imMin)/(imMax - imMin);
