function R = rotationMatrix(thetaY, thetaZ, boxSize)

     vectorizedSize = boxSize(1)*boxSize(2)*boxSize(3);
     R = zeros(vectorizedSize,vectorizedSize);
     for k = 1:boxSize(3)
         for j = 1:boxSize(2)
             for i = 1:boxSize(1)
                origin = backward(thetaY, thetaZ, i, j, k, boxSize);
                R(boxSize(2)*boxSize(1)*(k-1)+boxSize(1)*(j-1)+i,:) = resultingRow(origin(1), origin(2), origin(3), boxSize); 
             end
         end
     end
 
end