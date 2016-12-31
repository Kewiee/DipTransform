function B = calcB(angles,boxSize)
    %B = sparse(size(angles,1)*boxSize(1), boxSize(1)*boxSize(2)*boxSize(3));
    B = sparse(0,0);
    anglesInBatch = 20;
    numberOfBatches = ceil(size(angles,1) / anglesInBatch);
    for i =1:numberOfBatches
        disp(['batch ',num2str(i),'/',num2str(numberOfBatches)]);
        startAngles = (i-1)*anglesInBatch + 1;
        endAngles = i*anglesInBatch;
        if i == numberOfBatches
            endAngles = size(angles, 1);
        end
        tic
        B = [B; calcB_inBatches(angles(startAngles:endAngles,:),boxSize)];
        disp(['Added to large B: ', num2str(ceil(toc)),'[sec]']);
    end
end

function B = calcB_inBatches(angles,boxSize)

    volume = boxSize(1)*boxSize(2)*boxSize(3);
    R_theta = zeros(3*size(angles,1),3);
    disp('Concatenating R_theta...');
    for i = 1:size(angles,1)
        R_theta((3*(i-1) + 1):(3*i),:) = Rotation3x3(angles(i,1), angles(i,2));
    end
    disp('Generating Mesh grid...');
    [X,Y,Z] = meshgrid(1:boxSize(2),1:boxSize(1),1:boxSize(3));
    X = X - ceil(boxSize(2)/2);
    Y = Y - ceil(boxSize(1)/2);
    Z = Z - ceil(boxSize(3)/2);
    disp('Calculating origins...');
    origin = R_theta*[Y(:),X(:),Z(:)]';
    origin = permute(reshape(origin',volume,3,size(angles,1)),[2,1,3]);
    origin = reshape(origin,3,volume*size(angles,1));
    origin(1,:) = origin(1,:) + ceil(boxSize(1)/2);
    origin(2,:) = origin(2,:) + ceil(boxSize(2)/2);
    origin(3,:) = origin(3,:) + ceil(boxSize(3)/2);
    disp('Eliminating out of bounds...');
    rowIndices = find((origin(1,:)>=1).*(origin(1,:)<=boxSize(1)).*...
        (origin(2,:)>=1).*(origin(2,:)<=boxSize(2)).*(origin(3,:)>=1).*(origin(3,:)<=boxSize(3)));
    origin = round(origin); %In case of nearest neighbor approximation
    colIndices = sub2ind(boxSize,origin(1,rowIndices),origin(2,rowIndices),origin(3,rowIndices));
    
    tic
    disp('Generating R...');
    R = sparse(rowIndices, colIndices, ones(length(rowIndices),1),volume*size(angles,1),volume);
    timeR = ceil(toc);
    tic
    disp('Generating S...');
    S = sparse(kron(eye(size(angles,1)),sparse(flipud(sumZplains(boxSize)))));
    timeS = ceil(toc);
    tic
    disp('Generating B=S*R...');
    B = S*R;
    timeSR = ceil(toc);
    disp(['Done B_batch. R: ',num2str(timeR), '[sec], S: ', num2str(timeS), '[sec], S*R: ', num2str(timeSR),'[sec]']);
    
end
