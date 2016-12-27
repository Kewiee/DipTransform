function R = rotationAndSumMatrices(theta, phi, boxSize)
    
    R = [];
    for i = 1:length(theta)
        for j = 1:length(phi)
            Rtheta = rotationMatrix(theta(i), phi(j), boxSize);
            rotatedAndSumming = sumZplains(boxSize)*Rtheta;  
            R = [R; rotatedAndSumming];
        end
    end
    
end