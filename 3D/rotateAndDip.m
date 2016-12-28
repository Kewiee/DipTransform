function [volume, allSlices, B] = rotateAndDip(object, angles)

    volume = zeros(1, size(angles,1));
    allSlices = zeros(size(object,1)*size(angles,1),1);
    summationMatrix = sumZplains(size(object));
    B = [];
    for i=1:size(angles,1)
        theta = angles(i,1);
        phi = angles(i,2);
        disp(strcat('Rotating at angle: [',num2str(theta),',', num2str(phi),']',', ',num2str(i),'/',num2str(size(angles,1))));
        [R, slices] = calculateSlices(object, theta, phi);
        B = [B; sparse(flipud(summationMatrix*R))];
        allSlices(((i-1)*size(object,1)+1):(i*size(object,1))) = slices;
        volume(i) = sum(slices);
    end
    B = sparse(B);
end

