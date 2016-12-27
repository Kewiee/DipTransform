function R = calRotationMatrix(thetaY, thetaZ, boxSize)

    vectorizedSize = boxSize(1)*boxSize(2)*boxSize(3);
     R = sparse(vectorizedSize,vectorizedSize);
    
    [x_grid, y_grid, z_grid] = meshgrid(1:boxSize(2), 1:boxSize(1),1:boxSize(3));
    
    origin = backward(thetaY, thetaZ, y_grid(:)', x_grid(:)', z_grid(:)', boxSize);

    validIndices = find((origin(1,:)>=1).*(origin(1,:)<=boxSize(1)).*(origin(2,:)>=1).*(origin(2,:)<=boxSize(2)).*(origin(3,:)>=1).*(origin(3,:)<=boxSize(3)));
    [originRoundedNeighbors, proximity] = getRoundedNeighbors(origin(:,validIndices));
    R_rows = 1:vectorizedSize;
    R_rows = R_rows(validIndices);
    R_rows = repmat(R_rows,[1 length(originRoundedNeighbors)/length(R_rows)]);

    linearIndicesInBox = sub2ind(boxSize, originRoundedNeighbors(1,:), originRoundedNeighbors(2,:), originRoundedNeighbors(3,:));

    sparseMatrixData = unique([R_rows' linearIndicesInBox' proximity'],'rows');

    R = sparse(sparseMatrixData(:,1), sparseMatrixData(:,2), sparseMatrixData(:,3), vectorizedSize, vectorizedSize);    
end


function [allRoundedOrigin,proximity] = getRoundedNeighbors(origin)
    actions = cell(2,1);
    actions{1} = @floor;
    actions{2} = @ceil;
    allRoundedOrigin = [];
    proximity = [];
    for i=1:(length(actions)^size(origin,1))
        roundOrigin = origin;
        actionIndices = de2bi((i-1),size(origin,1)) + ones(1, size(origin,1));
        for k=1:size(origin,1);           
            roundOrigin(k,:) = actions{actionIndices(k)}(origin(k,:));
        end
        allRoundedOrigin = [allRoundedOrigin roundOrigin];
        proximity = [proximity prod(1 - abs(roundOrigin - origin))];
    end
    
end
