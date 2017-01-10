function Ball = generateIdealBall(resolution)

    l = 1:resolution;

    [X, Y, Z] = meshgrid(l,l,l);
    X = X - length(l)/2;
    Y = Y - length(l)/2;
    Z = Z - length(l)/2;
    Ball = (sqrt(X.^2 + Y.^2 + Z.^2) < length(l)/2);
    
end