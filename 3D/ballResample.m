clc; clear; close all;

load ball200Sample.mat;

resolution = 40;
S = 440*270;
d = 2;
BBlength = 200;

sliceToAlgorithm = resampleAlignAndSmooth(ball200Sample, resolution, d, S, BBlength);

Ball = generateIdealBall(resolution);
angle = randi([0 179], 1, 2);
B = calcB(angle,size(Ball));
slices = rotateAndDipImproved(Ball, B);
hold on; plot(1:length(slices),slices,'g');


