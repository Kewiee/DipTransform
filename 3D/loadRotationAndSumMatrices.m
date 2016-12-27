function R = loadRotationAndSumMatrices(theta, phi)
    dataDir = 'data/';
    R = [];
    allRows = [];
    allCols = [];
    allValues = [];
    for i = 1:length(theta)
        for j = 1:length(phi)
            [i j]
            filename = strcat('rotatedAndSumming','_phi_',num2str(phi(i)),'_theta_',num2str(theta(i)));
            load(strcat(dataDir,filename,'.mat'));
            
            [rowIndices, colIndices, values] = find(rotatedAndSumming);
            rowIndices = rowIndices + (size(rotatedAndSumming,1)*((i-1)*length(theta) + j - 1));
            allRows = [allRows; rowIndices];
            allCols = [allCols; colIndices];
            allValues = [allValues; values];
        end
    end
    R = sparse(allRows, allCols, allValues, size(rotatedAndSumming,1)*length(theta)*length(phi), size(rotatedAndSumming,2));
end