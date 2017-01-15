clc; close all; clear;

path = '../3dDips/3cats_fixture_0113-3mm-R1-0-35-R2-0-60.csv';
% Read dips
[Ryz,waterHeight] = parseDips(path);
% Parameters
n = 50; %Resolution
S = 540*340; %Cross section area [mm^2]
d = 3; %Robot's steps [mm]
BBlength = 330; %Length of bounding box; [mm]
zCenter = 180;%157; %distace from the center of the object to origin.
%zCenter = 0;

addpath(genpath(('../third_party')));
modelsDir = '../3dmodels/';

% Extract original
modelName = 'finalcats_stl';
pad = 0;
modelPath = strcat(modelsDir, modelName, '.stl');
original = dippingPreprocessing(modelPath, n, pad);

% Reconstruction algorithm
I = reconstructObjectFromRealSamples(waterHeight,Ryz,n,S,d,zCenter,BBlength,original);
h = showVoxel(I, 'Reconstructed');