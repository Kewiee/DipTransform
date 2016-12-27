function R = resultingRow(row, col, imageSize)
    
    R = zeros(1,imageSize(1)*imageSize(2));
    flag = isOutOfBound(row, col, imageSize);
    
    if(flag)
        return
    else

        a = row - floor(row);
        b = col - floor(col);
        floorRow = floor(row);
        floorCol = floor(col);   
        ceilRow = floorRow + 1;
        ceilCol = floorCol + 1;    
        
        if (a == 0 && b == 0)
            R(imageSize(2)*(col-1) + row) = 1;
        elseif (a == 0)
            R(imageSize(2)*(ceilCol-1) + row) = b;
            R(imageSize(2)*(floorCol-1) + row) = 1-b;
        elseif (b == 0)
            R(imageSize(2)*(col-1) + ceilRow) = a;
            R(imageSize(2)*(col-1) + floorRow) = 1-a;       
        else        
            R(imageSize(2)*(ceilCol-1) + ceilRow) = a*b;
            R(imageSize(2)*(floorCol-1) + ceilRow) = a*(1-b);
            R(imageSize(2)*(floorCol-1) + floorRow) = (1-a)*(1-b);
            R(imageSize(2)*(ceilCol-1) + floorRow) = (1-a)*b;
        end
    end
end