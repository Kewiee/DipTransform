clear; close all; clc;

A = imread('../images/elephant.jpg');
B = dippingPreprocessing(A);
clear A;

boundary = getBoundary(B);
imshowBinary(B(boundary.rows(1):boundary.rows(2), boundary.cols(1):boundary.cols(2)));
figure; imshow(B,[]);
iptsetpref('ImshowBorder','tight');
title('Molecule');


theta = randi([0 179], 1, 15);
%theta = 1:180;
[frames, volume, slices] = rotateAndDip(B, theta);
iptsetpref('ImshowBorder','tight');
figure; imshow(slices,[]); colormap cool;


title('Dip transform - Molecule');
xlabel('$\theta$','interpreter','latex');
ylabel('$\frac{dV}{dt}$','interpreter','latex');

I = reconstructObject(slices, theta, size(B));
E = calculateBinaryError(I,B);

figure; imshow(I,[]);
title('Reconstruction - Molecule');

imshowBinary(I(boundary.rows(1):boundary.rows(2), boundary.cols(1):boundary.cols(2)), [0 0 255]/255);

