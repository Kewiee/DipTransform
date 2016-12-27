function [rotatedImage, slices] = calculateSlices( binaryImage, angle )
    
    rotatedImage = imrotate(binaryImage, angle, 'nearest', 'crop');
    %R = rotationMatrix(angle, size(binaryImage));
    %rotatedImage = R*binaryImage(:);
    %rotatedImage = reshape(rotatedImage, size(binaryImage));
    slices = flipud(sum(rotatedImage,2));
    
end

