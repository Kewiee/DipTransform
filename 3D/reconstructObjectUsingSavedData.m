function I = reconstructObjectUsingSavedData(slices, theta, phi, boxSize)

    y = slices(:);
    A = loadRotationAndSumMatrices(theta, phi);
    I = lsmr(A,y); %pinv(A)*y;
    I = reshape(I, boxSize);
    %I = rot90(I,2); %Because the measurments were from top to bottom.
    th = mean(mean(mean(I)));
    I = (I > th);
    
    
end