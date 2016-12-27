function R = buildRotationsMatrix(theta, imageSize)
    
    R = [];
    for i = 1:length(theta)
        Rtheta = rotationMatrix(theta(i),imageSize);
        rotatedAndSumming = kron(ones(1,imageSize(2)),eye(imageSize(1)))*Rtheta;  
        R = [R; rotatedAndSumming];
    end
    
end