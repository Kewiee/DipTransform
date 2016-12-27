function C = dippingPreprocessing(modelPath, resolution, pad)
    B = VOXELISE(resolution- 2*pad,resolution - 2*pad,resolution- 2*pad,modelPath,'xyz');
    C = zeros(resolution, resolution, resolution);
    C((pad+1):(end-pad),(pad+1):(end-pad), (pad+1):(end-pad)) = B;
end

