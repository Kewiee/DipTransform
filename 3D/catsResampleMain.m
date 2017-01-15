clc; clear; close all;

load cat2mmSample.mat;
%load frame2mmSample.mat;

resolution = 50;
R1 = 100/2; R2 = 130/2; R3 = 140/2;
S = 540*340 - pi*(R1^2+R2^2+R3^2);
d = 2;
BBlength = 250;

sliceToAlgorithm = resampleAlignAndSmooth(cat2mmSample, resolution, d, S, BBlength, 0, 0);
hold on; plot(1:length(sliceToAlgorithm),sliceToAlgorithm);

addpath(genpath(('../third_party')));
modelsDir = '../3dmodels/';
modelName = 'finalcats_stl';

modelPath = strcat(modelsDir, modelName, '.stl');
pad = 2;
Original = dippingPreprocessing(modelPath, resolution, pad);
angle = [0,0];
[B,R] = calcBandR(angle,size(Original));
%originalRotated = R*Original(:);
slices = rotateAndDipImproved(Original, B);
hold on; plot(1:length(slices),slices,'g');
legend('Original dip - smoothed','Simulated dip')
%h = showVoxel(reshape(originalRotated,size(Original)), 'cats');
%h = showVoxel(Original, 'cats');
