function [ v ] = recordRecon(modelName, resolution, reconstructions, numOfAngles )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

numberOfReconstructions = 24; %size(reconstructions,4)
for i = 1:numberOfReconstructions

    I_filtered = reconstructions(:,:,:,i);
    h = showVoxel(I_filtered);
    if nargin > 3
        title(['Number of Dips = ',num2str(numOfAngles(i))],'interpreter','latex','fontSize',14);
    end
    axis([1 size(I_filtered,1) 1 size(I_filtered,2) 1 size(I_filtered,3)])
    F(i) = getframe(gcf);
    close(gcf);
end

v = VideoWriter(strcat(modelName,'_res_',num2str(resolution),'_angles.mp4'),'MPEG-4');
v.FrameRate = 4;
open(v); writeVideo(v,F); close(v);




end

