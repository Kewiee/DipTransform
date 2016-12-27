function origin = backward(thetaY, thetaZ, n, m, l, boxSize)
    
    n = n - ceil(boxSize(1)/2);
    m = m - ceil(boxSize(2)/2);
    l = l - ceil(boxSize(3)/2);
    thetaY = deg2rad(thetaY);
    thetaZ = deg2rad(thetaZ);
    Ry = [cos(thetaY) 0 sin(thetaY); 0 1 0; -sin(thetaY) 0 cos(thetaY)];
    Rz = [cos(thetaZ) -sin(thetaZ) 0; sin(thetaZ) cos(thetaZ) 0; 0 0 1];
    R = Ry*Rz;
    dest = [n; m; l];
    source = R\dest;
    origin = [source(1,:)+ceil(boxSize(1)/2); source(2,:)+ceil(boxSize(2)/2); source(3,:)+ceil(boxSize(3)/2)];
    origin = roundToDecimal(origin,5);
  
end

function result = roundToDecimal(X, N)
    result = round(X*10^N)/(10^N);
end