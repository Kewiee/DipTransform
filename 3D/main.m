clear; close all; clc;

addpath(genpath(('../third_party')));
modelsDir = '../3dmodels/';

%% Parameters
modelName = 'jerboa';

resolution = 40;

pad = floor( ((sqrt(3) - 1)/(2 * sqrt(3))) * resolution + 1);
numberOfAngles = (resolution - 2*pad)^2;

%% Model initialization
modelPath = strcat(modelsDir, modelName, '.stl');
B = dippingPreprocessing(modelPath, resolution, pad);

h = showVoxel(B, 'Original');
movegui(h,[70,250]);
%% Measure dip
tic
angles = randi([0 179], numberOfAngles, 2);
[frames, volume, slices] = rotateAndDip(B, angles, false);
toc; disp('Dipped');

%% Reconstruct
tic
[I, I_soft] = reconstructObject(slices, angles, size(B));
I_filtered = zeros(size(I));
I_filtered((pad+1):(end-pad), (pad+1):(end-pad),(pad+1):(end-pad)) = I((pad+1):(end-pad), (pad+1):(end-pad),(pad+1):(end-pad));
h = showVoxel(I_filtered, 'Reconstructed');
movegui(h,[650,250]);
toc; disp('reconstructObject');
E = calculateBinaryError(I_filtered,B);
