function [h] = showVoxel( voxel, name )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    if nargin < 2
        name = ' ';
    end
    tempFilePath = 'temp.stl';
    CONVERT_voxels_to_stl(tempFilePath, voxel ,1:size(voxel,1),1:size(voxel,2),1:size(voxel,3));
    [vertices,faces,normals,~] = stlRead(tempFilePath);
    h = stlPlot(vertices,faces,name);
    delete(tempFilePath);
    grid off;   
%     set(gca, 'box', 'off') ;
%     set(gca, 'xtick', [], 'ytick', [], 'ztick',[]) ;
%     set(gca, 'xcolor', 'w', 'ycolor', 'w','zcolor','w') ;
%     set(gca,'Color',[0 0 0]);
    %set(gca, 'visible', 'on') ;
    set(gca, 'visible', 'off') ;
end

