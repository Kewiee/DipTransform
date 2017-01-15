function sliceToAlgorithm = resampleAlignAndSmooth(v, n, d, S, BBlength, z, theta, frame)
    
    %Caluclate frame volume
    if (nargin > 7)
        frmaeInBB = samplesToBB(frame,d,BBlength);
        frameResampled = resampleDip(frmaeInBB,d,S,n+1,'spline');       
    else
        frameResampled = zeros(1,n+1);        
    end
    
    %Reduce dZ from the starting points
    v = modifyStartPoint(v,d,z,theta);
    
    %Select the samples which are relevant to the BB size (otherwise complete)
    vInBB = samplesToBB(v,d,BBlength);
    
    %Interpolationg
    volumesResampled = resampleDip(vInBB,d,S,n+1,'spline');    
    volumesResampled = volumesResampled - frameResampled;
    volumesDiff = diff(volumesResampled);
    voxelVolume = (BBlength/n)^3;
    sliceToAlgorithm = volumesDiff/voxelVolume;
    
    %Smoothing
    %figure; plot(1:length(sliceToAlgorithm),sliceToAlgorithm);
    gaussFilter = gausswin(5);
    sliceToAlgorithm = conv(sliceToAlgorithm, gaussFilter/sum(gaussFilter),'same');
    
end
 
function vCorrected = modifyStartPoint(v,d,z,theta)
    
    if (z == 0)
        vCorrected = v;
        return;
    end
      
    dz = z*(1-cos(deg2rad(theta)));
    
    samplesIn_dz = floor(dz/d);
    if (samplesIn_dz > length(v))
        vCorrected = [];
    else
        vCorrected = v((samplesIn_dz+1):length(v));
    end
    
    
end

function vInBB = samplesToBB(v,d,BBlength)
        
    slicesHeightAccumulated = measures2height(v,d);
    
    assert(length(v) == length(slicesHeightAccumulated));
    
    %figure;stem(1:length(slicesHeightAccumulated),slicesHeightAccumulated);
    %hold on;
    %plot(1:length(v),BBlength*ones(1,length(v)),'r');
    
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
    
    %hold on; stem(1:length(vInBB),vInBB,'x');
    %xlabel('Sample','interpreter','latex');
    %ylabel('Height [mm]','interpreter','latex');
    
end

function slicesHeightAccumulated = measures2height(v,d)
    
    waterHeightDiff = diff(v);
    slicesHeightDiff = waterHeightDiff + d;
    slicesHeightAccumulated = cumsum([0; slicesHeightDiff]);
end
