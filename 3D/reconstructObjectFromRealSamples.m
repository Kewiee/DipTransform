function I = reconstructObjectFromRealSamples(waterHeight,Ryz,n,S,d,zCenter,BBlength,original)
    
    assert(size(waterHeight,2) == size(Ryz,1));
    slices = [];
    figure;
    for i = 1:size(Ryz,1)
        sliceToAlgorithm = resampleAlignAndSmooth(waterHeight(:,i), n, d, S, BBlength, zCenter, Ryz(i,1));
        subplot(4,8,i); plot(1:length(sliceToAlgorithm),sliceToAlgorithm);
        hold on; plot(1:n,calcB(Ryz(i,:),n*ones(1,3))*original(:));
        %improvedSliceToAlgorithm = improveSliceToAlgorithm(sliceToAlgorithm,original,Ry(i),Rz(i));
        disp(['Dip ', num2str(i),'/',num2str(size(Ryz,1))]);
        slices = [sliceToAlgorithm, slices];
    end
    
    boxSize = n*ones(1,3);
    B = calcB(Ryz,boxSize);
    [I, I_soft] = reconstructObject(slices', boxSize, B);

end