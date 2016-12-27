function [ paperImage ] = imshowBinary(binaryImage, foregroundColor, backgroundColor)
% showBinaryImage
%   Inputs:
%       binaryImage - The image to be colored
%       foregroundColor - The color white object in the image will be.
%       backgroundColor - The color the black background will be (default
%       white)
%   Outputs:
%       paperImage - The colored image.
%       Also the image is show using imshow.

    if nargin < 3
        backgroundColor = [255 255 255]/255; %white
    end
    if nargin < 2
        foregroundColor = [5 231 247]/255; % pale blue
    end
    
    paperImage = mat2gray(double(binaryImage));
    if size(binaryImage,3) < 3
        paperImage = repmat(paperImage, [1 1 3]);
    end
      
    backgroundImage = toImageWithColor(size(paperImage), backgroundColor);
    foregroundImage = toImageWithColor(size(paperImage), foregroundColor);
    
    paperImage = (1 - paperImage).*backgroundImage + paperImage.*foregroundImage;
    figure; imshow(uint8(255*mat2gray(paperImage)));
end

function colorImage = toImageWithColor(imageSize, color)
    colorAsImageBands = zeros(1,1,3);
    colorAsImageBands(1,1,:) = color;
    colorImage = repmat(colorAsImageBands, [imageSize(1), imageSize(2), 1]);
end