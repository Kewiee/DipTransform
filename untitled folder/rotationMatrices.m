function R = rotationMatrices(theta,phi,object)
    
    vectorizedSize = size(object,1)*size(object,2)*size(object,3);
    R = zeros(vectorizedSize,vectorizedSize,length(theta));
    
    for i = 1:length(theta)
        for j = 1:length(phi)
            R(:,:,length(theta)*(i-1)+j) = rotationMatrix(theta(i),phi(i),object);
        end
    end

end