function R = rotationMatrices(theta,image)
    
    vectorizedSize = size(image,1)*size(image,2);
    R = zeros(vectorizedSize,vectorizedSize,length(theta));
    
    for i = theta
       R(:,:,i) = rotationMatrix(i,image);
    end

end