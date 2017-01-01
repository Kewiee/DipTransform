clear; close all; clc;

addpath(genpath(('../third_party')));
modelsDir = '../3dmodels/';

%% Parameters
modelName = 'jerboa';

resolution = 120;

pad = 0;
%pad = floor( ((sqrt(3) - 1)/(2 * sqrt(3))) * resolution + 1);

%% Model initialization
modelPath = strcat(modelsDir, modelName, '.stl');
Original = dippingPreprocessing(modelPath, resolution, pad);

h = showVoxel(Original, 'Original');
movegui(h,[70,250]);

%% Load B
load(strcat('res_',num2str(resolution),'.mat'));
disp('Loaded B');

%% Dip
tic
slices = rotateAndDipImproved(Original, B);
toc; disp('Dipped');

%% Reconstruct
tic
[I, I_soft] = reconstructObject(slices, size(Original), B);

I_filtered = zeros(size(I));
I_filtered((pad+1):(end-pad), (pad+1):(end-pad),(pad+1):(end-pad)) = I((pad+1):(end-pad), (pad+1):(end-pad),(pad+1):(end-pad));
h = showVoxel(I_filtered, 'Reconstructed');
movegui(h,[650,250]);
toc; disp('reconstructObject');
E = calculateBinaryError(I_filtered,Original);

%save(strcat(modelName,'_res_',num2str(resolution),'.mat'),'resolution','pad','I','I_soft','I_filtered','Original','E');

