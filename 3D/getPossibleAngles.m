function [phi, theta] = getPossibleAngles(dataDir)
    phi = [];
    theta = [];
    
    files = dir(dataDir);
    
    for i=1:length(files)
        fileData = files(i);
        if fileData.isdir == 1
            continue;
        end
        filename = files(i).name;
        
        theta = [theta getAngleValue(filename, 'theta')];
        phi = [phi getAngleValue(filename, 'phi')];

    end
    theta = unique(theta);
    phi = unique(phi);
end

function angle = getAngleValue(filename, angleName)
    splttedByAngle = strsplit(filename, strcat(angleName,'_'));
    splttedByAngle = splttedByAngle(2);
    splttedByAngle = strsplit(splttedByAngle{1},{'_','.'});
    angleAsString = splttedByAngle(1);
    angle = str2num(angleAsString);
end