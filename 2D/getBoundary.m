function [ boundary ] = getBoundary( binaryImage )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    if size(binaryImage,3) > 1
        binaryImage = sum(binaryImage,3)/3;
    end
     boundingBox = regionprops(binaryImage,'BoundingBox');
     boundingBox = ceil(boundingBox.BoundingBox);  
     boundary = struct;
     boundary.rows = [boundingBox(2), (boundingBox(2) + boundingBox(4))];
     boundary.cols = [boundingBox(1), (boundingBox(1) + boundingBox(3))]; 
end

