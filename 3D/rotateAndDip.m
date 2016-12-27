function [F, volume, allSlices] = rotateAndDip(object, angles, makeVideo)

    volume = zeros(1, size(angles,1));
    allSlices = []; 
    for i=1:size(angles,1)
        theta = angles(i,1);
        phi = angles(i,2);

        disp(strcat('Rotating at angle: [',num2str(theta),',', num2str(phi),']'));
        [rotatedObject, slices] = calculateSlices(object, theta, phi);
        %slices = alignFirstNonZero(slices);
        allSlices = [allSlices, slices];
        volume(i) = sum(slices);
%             if (makeVideo)
%                 subplot(1,2,1);
%                 imshow(rotatedImage);
%                 title(['Dipping angle: \theta = ',num2str(theta(i))]);
%                 subplot(1,2,2);
%                 plot(1:length(slices), slices);
%                 title('Volume derivative over time','interpreter','latex');
%                 xlim([0 100]);
%                 ylim([0 100]);
%                 xlabel('Time');
%                 ylabel('$dV/dt$','interpreter','latex');
%                 F(i) = getframe(gcf);
%             else
%                 F = false;
%             end 
    end
%     volume = zeros(1, length(theta));
%     allSlices = []; 
%     for i = 1:length(theta)
%         [rotatedImage, slices] = calculateSlices(image, theta(i));
%         %slices = alignFirstNonZero(slices);
%         allSlices = [allSlices, slices];
%         volume(i) = sum(slices);
%         if (makeVideo)
%             subplot(1,2,1);
%             imshow(rotatedImage);
%             title(['Dipping angle: \theta = ',num2str(theta(i))]);
%             subplot(1,2,2);
%             plot(1:length(slices), slices);
%             title('Volume derivative over time','interpreter','latex');
%             xlim([0 100]);
%             ylim([0 100]);
%             xlabel('Time');
%             ylabel('$dV/dt$','interpreter','latex');
%             F(i) = getframe(gcf);
%         else
             F = false;
%         end        
%     end
end

