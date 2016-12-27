function [F, volume, allSlices] = rotateAndDip(image, theta, makeVideo)
    if nargin < 3
        makeVideo = 0;
    end
    
    volume = zeros(1, length(theta));
    allSlices = []; 
    for i = 1:length(theta)
        [rotatedImage, slices] = calculateSlices(image, theta(i));
        %slices = alignFirstNonZero(slices);
        allSlices = [allSlices, slices];
        volume(i) = sum(slices);
        if (makeVideo)
            subplot(1,2,1);
            imshow(rotatedImage);
            title(['Dipping angle: \theta = ',num2str(theta(i))]);
            subplot(1,2,2);
            plot(1:length(slices), slices);
            title('Volume derivative over time','interpreter','latex');
            xlim([0 100]);
            ylim([0 100]);
            xlabel('Time');
            ylabel('$dV/dt$','interpreter','latex');
            F(i) = getframe(gcf);
        else
            F = false;
        end        
    end
end

