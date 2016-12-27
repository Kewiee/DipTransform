function [I_thresh, I] = reconstructObject(slices, angles, boxSize)

    y = slices(:);
    A = rotationAndSumMatrices(angles, boxSize);
    I = lsmr(A,y); %pinv(A)*y;
    I = reshape(I, boxSize);
    %I = rot90(I,2); %Because the measurments were from top to bottom.
    th = mean(mean(mean(I)));
    th = max([th,0.5]);
    I_thresh = (I > th);
    
end