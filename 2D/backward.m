function origin = backward(theta, row, col, imageSize)
    
    row = row - ceil(imageSize(1)/2);
    col = col - ceil(imageSize(2)/2);
    theta = deg2rad(theta);
    R = [cos(theta) -sin(theta); sin(theta) cos(theta)];
    b = [row;col];
    inversed = R\b;
    origin = [inversed(1) + ceil(imageSize(1)/2); inversed(2) + ceil(imageSize(2)/2)];
    origin = roundToDecimal(origin,5);
    
end

function result = roundToDecimal(X, N)
    result = round(X*10^N)/(10^N);
end