function R = rotationAndSumMatrices(angles, boxSize)
    
    R = [];
    summationMatrix = sumZplains(boxSize);
    for i = 1:size(angles,1)
        theta = angles(i,1);
        phi = angles(i,2);
        Rtheta = calRotationMatrix(theta, phi, boxSize);
        MULTIPLY = summationMatrix*Rtheta;
        rotatedAndSumming = sparse(flipud(MULTIPLY));
        R = [R; rotatedAndSumming];

    end
    
end