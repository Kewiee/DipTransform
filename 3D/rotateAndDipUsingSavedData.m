function allSlices = rotateAndDipUsingSavedData(object, theta, phi)

    R = loadRotationAndSumMatrices(theta, phi);
   allSlices = R*object(:);
end