function I = reconstructObject(slices, theta, imageSize)

    y = slices(:);
    A = buildRotationsMatrix(theta, imageSize);
    I = lsmr(A,y); % I = pinv(A)*y;
    I = reshape(I, imageSize);
    I = rot90(I,2); %Because the measurments were from top to bottom.
    figure; imshow(I,[]);
    I = im2bw(I,0.5);
    
end