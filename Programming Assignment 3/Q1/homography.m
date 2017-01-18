img = im2double(rgb2gray(imread('ufcise_input.jpg')));
%imshow(img)
%[c,r,P] = impixel(img)

c = [58 256 268 81]';
r = [61 64 275 290]';

%base = [0 1; 9 0; 9 9; 0 8.8];
base = [0 1; 9 0; 9 9; 0 8.8];
%base = [0 1; 9 0; 9 9; 0 8.8];
tf = cp2tform([c r],base*25,'projective');

[xf1, XData, YData] = imtransform(img,tf);
imshow(xf1)
imwrite(xf1,[name '_registered.jpg']);




