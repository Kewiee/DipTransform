function [I_thresh, I] = reconstructObject(slices, boxSize, B)

    y = slices(:);
    disp('LSMRing...');
    I = lsmr(B, y, 0.1); %pinv(A)*y;
    I = reshape(I, boxSize);
    %I = rot90(I,2); %Because the measurments were from top to bottom.
    th = mean(mean(mean(I)));
    th = max([th,0.5]);
    I_thresh = (I > th);
    
end