function [R, slices] = calculateSlices( object, theta, phi )
    
    R = calRotationMatrix(theta, phi, size(object));
    rotatedObject = R*object(:);
    rotatedObject = reshape(rotatedObject, size(object));
    slices = flipud(sum(sum(rotatedObject,2),3));
    
end

