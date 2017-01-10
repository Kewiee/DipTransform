function sliceToAlgorithm = resampleAlignAndSmooth(v, n, d, S, BBlength, z, theta)
    
    %Reduce dZ from the starting points (optional)
    if (nargin > 5)
        v = modifyStartPoint(v,d,z,theta);
    end

    %Select the samples which are relevant to the BB size (otherwise complete)
    vInBB = samplesToBB(v,d,BBlength);
    
    %Interpolationg
    volumesResampled = resampleDip(vInBB,d,S,n,'spline');
    volumesDiff = diff(volumesResampled);
    voxelVolume = (BBlength/n)^3;
    sliceToAlgorithm = volumesDiff/voxelVolume;
    
    %Smoothing
    figure; plot(1:length(sliceToAlgorithm),sliceToAlgorithm);
    gaussFilter = gausswin(5);
    sliceToAlgorithm = conv(sliceToAlgorithm, gaussFilter/sum(gaussFilter),'same');

    hold on; plot(1:length(sliceToAlgorithm),sliceToAlgorithm,'r');
    
end
 
function vCorrected = modifyStartPoint(v,d,z,theta)
    
    dz = z*(1-cos(deg2rad(theta)));
    
    samplesIn_dz = floor(dz/d);
    if (samplesIn_dz > length(v))
        vCorrected = [];
    else
        vCorrected = v(samplesIn_dz:length(v));
    end
    
    
end

function vInBB = samplesToBB(v,d,BBlength)
        
    slicesHeightAccumulated = measures2height(v,d);
    
    assert(length(v) == length(slicesHeightAccumulated));
    
    stem(1:length(slicesHeightAccumulated),slicesHeightAccumulated);
    hold on;
    plot(1:length(v),BBlength*ones(1,length(v)),'r');
    
    if (slicesHeightAccumulated(end) < BBlength)
        holes = floor((BBlength - slicesHeightAccumulated(end))/d);
        vInBB = [v; v(end)*ones(holes,1)];
    else 
      [minDist, minIndx] = min(abs(BBlength - slicesHeightAccumulated));
      if ((BBlength - slicesHeightAccumulated(minIndx)) >= 0)
          vInBB = v(1:minIndx);
      else
          vInBB = v(1:(minIndx-1));
      end        
    end
    
    hold on; stem(1:length(vInBB),vInBB,'x');
end

function slicesHeightAccumulated = measures2height(v,d)
    
    waterHeightDiff = diff(v);
    slicesHeightDiff = waterHeightDiff + d;
    slicesHeightAccumulated = cumsum([0; slicesHeightDiff]);
end
