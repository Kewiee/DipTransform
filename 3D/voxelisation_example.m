clear all; close all; clc;

addpath(genpath(('../third_party')));
modelsDir = '../../3dmodels/';

%%

modelName = 'jerboa.stl';

%Voxelise the STL:
[OUTPUTgrid] = VOXELISE(100,100,100,strcat(modelsDir, modelName),'xyz');
