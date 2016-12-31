clear; close all; clc;

addpath(genpath(('../third_party')));
modelsDir = '../3dmodels/';

%% Parameters
modelName = 'octopus';

resolution = 60;

pad = floor( ((sqrt(3) - 1)/(2 * sqrt(3))) * resolution + 1);
pad = 4;


%% Model initialization
modelPath = strcat(modelsDir, modelName, '.stl');
Original = dippingPreprocessing(modelPath, resolution, pad);

h = showVoxel(Original,'Original');
title('Original','interpreter','latex','fontSize',14);
movegui(h,[70,250]);
%% Measure dip
tic
maxNumberOfAngles = (resolution-2*pad)^2;
angles = randi([0 179], maxNumberOfAngles, 2);
B = calcB(angles,size(Original));
slices = rotateAndDipImproved(Original, B);
toc; disp('Dipped');

%% Reconstruct
tic
numOfAngles = 100:25:maxNumberOfAngles;
Error = zeros(length(numOfAngles),1);
for i = 1:length(numOfAngles)
    [I, I_soft] = reconstructObject(slices(1:(numOfAngles(i)*size(Original,1))), size(Original), B(1:(numOfAngles(i)*size(Original,1)),:));

    I_filtered = zeros(size(I));
    I_filtered((pad+1):(end-pad), (pad+1):(end-pad),(pad+1):(end-pad)) = I((pad+1):(end-pad), (pad+1):(end-pad),(pad+1):(end-pad));
    h = showVoxel(I_filtered, 'Reconstructed');
    movegui(h,[650,250]);
    title(['Number of Dips = ',num2str(numOfAngles(i))],'interpreter','latex','fontSize',14);
    F(i) = getframe(gcf);
    toc; disp('reconstructObject');
    E = calculateBinaryError(I_filtered,Original);
    if (E == 0)
        break;
    end
    Error(i) = E;
end

v = VideoWriter(strcat(modelName,'_res_',num2str(resolution),'_angles.mp4'));
v.FrameRate = 4;
open(v); writeVideo(v,F); close(v);
g = figure; 
plot(numOfAngles,Error);
title('Reconstruction Error Vs. Number of Dips','interpreter','latex','fontSize',14);
savefig(g,strcat(modelName,'_res_',num2str(resolution),'_angles.fig'));
save(strcat(modelName,'_res_',num2str(resolution),'_package.mat'),'-v7.3');

