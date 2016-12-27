function R = rotationMatrix(theta,imageSize)
    
    vectorizedSize = imageSize(1)*imageSize(2);
    R = zeros(vectorizedSize,vectorizedSize);
    for j = 1:imageSize(2)
        for i = 1:imageSize(1)
            origin = backward(theta, i, j, imageSize);
            R(imageSize(2)*(j-1)+i,:) = resultingRow(origin(1), origin(2), imageSize);           
        end
    end
 
end