function [rotatedObject, slices] = calculateSlices( object, theta, phi )
    
    %rotatedImage = imrotate(binaryImage, angle, 'nearest', 'crop');
    R = calRotationMatrix(theta, phi, size(object));
    rotatedObject = R*object(:);
    rotatedObject = reshape(rotatedObject, size(object));
    slices = flipud(sum(sum(rotatedObject,2),3));
    
end

