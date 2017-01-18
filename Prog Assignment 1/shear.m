img = imread('thumbs_up.png');  %# Read a sample grayscale image
img = double(img);              %# Convert the image to type double
[nRows,nCols] = size(img);      %# Get the image size
[x,y] = meshgrid(1:nRows,1:nCols);  %# Create coordinate values for the pixels
coords = [x(:)'; y(:)'];            %# Collect the coordinates into one matrix
shearMatrix = [1 3; 0 1];         %# Create a shear matrix
newCoords = shearMatrix*coords;     %# Apply the shear to the coordinates
newImage = interp2(img,...             %# Interpolate the image values
                   newCoords(1,:),...  %#   at the new x coordinates
                   newCoords(2,:),...  %#   and the new y coordinates
                   'linear',...        %#   using linear interpolation
                   0);                 %#   and 0 for pixels outside the image
%newImage = reshape(newImage,nRows,nCols);  %# Reshape the image data
newImage = uint8(newImage);                %# Convert the image to type uint8
