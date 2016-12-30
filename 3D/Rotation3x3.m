function R = Rotation3x3(thetaY, thetaZ)
    
    thetaY = deg2rad(thetaY);
    thetaZ = deg2rad(thetaZ);
    Ry = [cos(thetaY) 0 sin(thetaY); 0 1 0; -sin(thetaY) 0 cos(thetaY)];
    Rz = [cos(thetaZ) -sin(thetaZ) 0; sin(thetaZ) cos(thetaZ) 0; 0 0 1];
    R = Ry*Rz;
  
end