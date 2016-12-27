clear; close all; clc;

addpath(genpath(('../third_party')));
modelsDir = '../../3dmodels/';
%%

boxSize = [100 100 100];

theta = 1:4:180;%sort(unique(round(randi([0 179], 1, 30))));
phi = 1:4:180;%sort(unique(round(randi([0 179], 1, 30))));
for i = 1:length(theta)
    for j = 1:length(phi)
        filename = strcat('rotatedAndSumming_phi_',num2str(phi(j)),'_theta_',num2str(theta(i)))
        %if ~exist(filename,'file')
            Rtheta = calRotationMatrix(theta(i), phi(j), boxSize);
            rotatedAndSumming = sparse(flipud(sumZplains(boxSize)*Rtheta));
            try
                save(strcat('data/',filename,'.mat'), 'rotatedAndSumming');
            catch
                disp('problem');
                delete(filename);
            end
        %end
    end
end