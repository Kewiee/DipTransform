clear; close all; clc;

addpath(genpath(('../third_party')));
modelsDir = '../../3dmodels/';
dataDir = 'data/';
%%
resolution = 100*ones(3,1);
numberOfAngles = [40 40];
tic
modelName = 'elephant_with_rider.stl';

B = VOXELISE(resolution(1),resolution(2),resolution(3),strcat(modelsDir, modelName),'xyz');

[phi, theta] = getPossibleAngles(dataDir);
phi = sort(phi(randperm(length(phi), numberOfAngles(1))));
theta = sort(theta(randperm(length(theta), numberOfAngles(2))));

slices = rotateAndDipUsingSavedData(B, theta, phi);
disp('Dipped');
I = reconstructObjectUsingSavedData(slices, theta, phi, size(B));
disp('reconstructObject');
E = calculateBinaryError(I,B);
toc;
save('elephant_3d_100res.mat');