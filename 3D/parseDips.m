function [Ryz,waterHeight] = parseDips(path)

    M = csvread(path,1,1);
    
    Ryz = M(:,1:2);
    RzSize = length(unique(Ryz(:,1)));
    RySize = length(unique(Ryz(:,2)));
    numOfDips = RzSize*RySize;
    samplesPerDip = size(M,1)/numOfDips;
    
    assert(mod(samplesPerDip,1)==0);
    Ryz = Ryz(1:samplesPerDip:end,:);

    waterHeight = reshape(M(:,4),samplesPerDip,numOfDips);

end