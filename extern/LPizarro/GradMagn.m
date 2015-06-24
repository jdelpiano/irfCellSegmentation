function G = GradMagn(I)

hy = fspecial('sobel');
hx = hy';
Iy = imfilter(double(I), hy, 'replicate');
Ix = imfilter(double(I), hx, 'replicate');
G = sqrt(Ix.^2 + Iy.^2);

end