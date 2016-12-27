clear; close all; clc;

A = imread('../images/elephant.jpg');
B = dippingPreprocessing(A);
clear A;

measurments = [2 5 10 15 20]; %number of dippings
error = [];

for i = measurments
    
    theta = randi([0 179], 1, i);
    [frames, volume, slices] = rotateAndDip(B, theta, true);
    figure; imshow(slices,[]);
    I = reconstructObject(slices, theta, size(B));
    E = calculateBinaryError(I,B);
    error = [error, E];
    close all;
    
end
figure; imshow(I,[]);
figure; plot(measurments, 100 - error);
title('Accuracy Rate')