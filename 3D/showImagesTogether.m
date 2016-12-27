function showImagesTogether(horizontalImage,verticalImage,range)
    
    zCenter = ceil((range(3,1) + range(3,2))/2);
    xCenter = ceil((range(1,1) + range(1,2))/2);
    
    maxImages = max([horizontalImage(:); verticalImage(:)]);
    minImages = min([horizontalImage(:); verticalImage(:)]);
    
    verticalImage = toColormapCool(verticalImage, minImages, maxImages);
    horizontalImage = toColormapCool(horizontalImage, minImages, maxImages);

    figure;
        surface('XData',xCenter*ones(2,2),...
            'YData',[range(2,1) range(2,1); range(2,2) range(2,2)],...
            'ZData',[range(3,1) range(3,2); range(3,1) range(3,2)],...
            'CData',flipdim(verticalImage,1),...
            'FaceColor','texturemap','EdgeColor','none');
    
    surface('XData',[range(1,1) range(1,2); range(1,1) range(1,2)],...
            'YData',[range(2,1) range(2,1); range(2,2) range(2,2)],...
            'ZData',zCenter*ones(2,2),'CData',flipdim(horizontalImage,1),...
            'FaceColor','texturemap','EdgeColor','none');

    ylabel('dip level','FontSize',17,'FontWeight','bold','Interpreter','latex');
    xlabel('$\theta$','FontSize',17,'FontWeight','bold','Interpreter','latex');
    zlabel('{$\phi$}','FontSize',17,'FontWeight','bold','Interpreter','latex');

    axis([0 Inf 0 Inf]);
        
end

function coloredImage = toColormapCool(image, minVal, maxVal)
    image = (image - minVal)/maxVal;
    if size(image,3) == 1
        colorMap = colormap('cool');
        image = round((size(colorMap,1)-1)*image +1);
        coloredImage = reshape(colorMap(image(:),:), [size(image,1), size(image,2) 3]);
    else
        coloredImage = image;
    end
end


