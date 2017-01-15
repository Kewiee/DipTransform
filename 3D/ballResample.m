clc; clear; close all;

load ball200Sample.mat;

resolution = 40;
S = 440*270;
factor = 2;
d = 2*factor;
BBlength = 100;

ball200Sample = ball200Sample(1:factor:end);
sliceToAlgorithm = resampleAlignAndSmooth(ball200Sample(1:3:end), resolution, d, S, BBlength,0,0);

Ball = generateIdealBall(resolution);
angle = randi([0 179], 1, 2);
B = calcB(angle,size(Ball));
slices = rotateAndDipImproved(Ball, B);



