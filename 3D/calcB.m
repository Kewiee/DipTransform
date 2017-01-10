function B = calcB(angles,boxSize)
    %B = sparse(size(angles,1)*boxSize(1), boxSize(1)*boxSize(2)*boxSize(3));
    B = sparse(0,0);
    anglesInBatch = round(size(angles,1)/3);

    if anglesInBatch < 1
        anglesInBatch = 1;
    end
    numberOfBatches = ceil(size(angles,1) / anglesInBatch);
    disp('Generating S...');

    S_tilde = sparse(flipud(sumZplains(boxSize)));
    S = sparse(kron(eye(anglesInBatch), S_tilde));

    for i =1:numberOfBatches
        disp(['batch ',num2str(i),'/',num2str(numberOfBatches)]);
        startAngles = (i-1)*anglesInBatch + 1;
        endAngles = i*anglesInBatch;
        
        if i == numberOfBatches
            endAngles = size(angles, 1);
        end
        if (i == numberOfBatches) && ((endAngles - startAngles + 1) ~= anglesInBatch) % Last batch may not have numAngles = anglesInBatch
           S = sparse(kron(eye(endAngles - startAngles + 1), S_tilde));
        end
        
        tic

        %B((((startAngles-1)*boxSize(3))+1):(endAngles*boxSize(3)) ,:) = calcB_inBatches(angles(startAngles:endAngles,:),boxSize, S);
        

        B = [B; calcB_inBatches(angles(startAngles:endAngles,:),boxSize, S)];
        disp(['Added to large B: ', num2str(ceil(toc)),'[sec]']);
    end
end

function B = calcB_inBatches(angles,boxSize, S)
    tic
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
    origin = [Y(:),X(:),Z(:)]*R_theta';
    origin = permute(reshape(origin,volume,3,size(angles,1)),[2,1,3]);
    origin = reshape(origin,3,volume*size(angles,1));
    origin(1,:) = origin(1,:) + ceil(boxSize(1)/2);
    origin(2,:) = origin(2,:) + ceil(boxSize(2)/2);
    origin(3,:) = origin(3,:) + ceil(boxSize(3)/2);
    disp('Eliminating out of bounds...');
    rowIndices = find((origin(1,:)>=1).*(origin(1,:)<=boxSize(1)).*...
        (origin(2,:)>=1).*(origin(2,:)<=boxSize(2)).*(origin(3,:)>=1).*(origin(3,:)<=boxSize(3)));
    origin = round(origin); %In case of nearest neighbor approximation
    colIndices = sub2ind(boxSize,origin(1,rowIndices),origin(2,rowIndices),origin(3,rowIndices));
    disp(['Preparing data time: ',num2str(round(toc)), '[sec]']);
    tic
    disp('Generating R...');
    R = sparse(rowIndices, colIndices, ones(length(rowIndices),1),volume*size(angles,1),volume);
    timeR = round(toc);
    tic
    disp('Generating B=S*R...');
    B = S*R;
    timeSR = round(toc);
    disp(['Done B_batch. R: ',num2str(timeR), '[sec], S*R: ', num2str(timeSR),'[sec]']);
    
end
