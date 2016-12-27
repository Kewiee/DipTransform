function I = reconstructObject(slices, theta, phi, boxSize)

    y = slices(:);
    A = rotationAndSumMatrices(theta, phi, boxSize);
    I = lsmr(A, y); %More efficient then I = pinv(A)*y since A is sparse 
    I = reshape(I, imageSize);
    I = rot90(I,2); %Because the measurments were from top to bottom.
    figure; imshow(I,[]);
    I = im2bw(I,0.5);   
end