function R = resultingRow(n, m, l, boxSize)

    R = zeros(1,boxSize(1)*boxSize(2)*boxSize(3));
    flag = isOutOfBound(n, m, l, boxSize);
    
    if(flag)
        return
    else

        a = n - floor(n);
        b = m - floor(m);
        c = l - floor(l);
        floorRow = floor(n);
        floorCol = floor(m); 
        floorWidth = floor(l);
        ceilRow = floorRow + 1;
        ceilCol = floorCol + 1;  
        ceilWidth = floorWidth + 1; 
        
        if (a == 0 && b == 0 && c == 0)
            R(boxSize(2)*boxSize(1)*(l-1) + boxSize(1)*(m-1) + n) = 1;
        elseif (a == 0 && b == 0)
            R(boxSize(2)*boxSize(1)*(ceilWidth-1) + boxSize(1)*(m-1) + n) = c;
            R(boxSize(2)*boxSize(1)*(floorWidth-1) + boxSize(1)*(m-1) + n) = 1-c;
        elseif (a == 0 && c == 0)
            R(boxSize(2)*boxSize(1)*(l-1) + boxSize(1)*(ceilCol-1) + n) = b;
            R(boxSize(2)*boxSize(1)*(l-1) + boxSize(1)*(floorCol-1) + n) = 1-b;
        elseif (b == 0 && c == 0)
            R(boxSize(2)*boxSize(1)*(l-1) + boxSize(1)*(m-1) + ceilRow) = a;
            R(boxSize(2)*boxSize(1)*(l-1) + boxSize(1)*(m-1) + floorRow) = 1-a;
        elseif (a == 0)
            R(boxSize(2)*boxSize(1)*(ceilWidth-1) + boxSize(1)*(ceilCol-1) + n) = b*c;
            R(boxSize(2)*boxSize(1)*(floorWidth-1) + boxSize(1)*(ceilCol-1) + n) = b*(1-c);  
            R(boxSize(2)*boxSize(1)*(ceilWidth-1) + boxSize(1)*(floorCol-1) + n) = (1-b)*c;
            R(boxSize(2)*boxSize(1)*(floorWidth-1) + boxSize(1)*(floorCol-1) + n) = (1-b)*(1-c);
        elseif (c == 0)
            R(boxSize(2)*boxSize(1)*(l-1) + boxSize(1)*(ceilCol-1) + ceilRow) = b*a;
            R(boxSize(2)*boxSize(1)*(l-1) + boxSize(1)*(ceilCol-1) + floorRow) = b*(1-a);  
            R(boxSize(2)*boxSize(1)*(l-1) + boxSize(1)*(floorCol-1) + ceilRow) = (1-b)*a;
            R(boxSize(2)*boxSize(1)*(l-1) + boxSize(1)*(floorCol-1) + floorRow) = (1-b)*(1-a);
        elseif (b == 0)
            R(boxSize(2)*boxSize(1)*(ceilWidth-1) + boxSize(1)*(m-1) + ceilRow) = c*a;
            R(boxSize(2)*boxSize(1)*(ceilWidth-1) + boxSize(1)*(m-1) + floorRow) = c*(1-a);  
            R(boxSize(2)*boxSize(1)*(floorWidth-1) + boxSize(1)*(m-1) + ceilRow) = (1-c)*a;
            R(boxSize(2)*boxSize(1)*(floorWidth-1) + boxSize(1)*(m-1) + floorRow) = (1-c)*(1-a); 
        else        
            R(boxSize(2)*boxSize(1)*(ceilWidth-1) + boxSize(1)*(ceilCol-1) + ceilRow) = a*b*c;
            R(boxSize(2)*boxSize(1)*(floorWidth-1) + boxSize(1)*(ceilCol-1) + ceilRow) = a*b*(1-c);
            R(boxSize(2)*boxSize(1)*(ceilWidth-1) + boxSize(1)*(floorCol-1) + ceilRow) = a*(1-b)*c;
            R(boxSize(2)*boxSize(1)*(ceilWidth-1) + boxSize(1)*(ceilCol-1) + floorRow) = (1-a)*b*c;
            R(boxSize(2)*boxSize(1)*(ceilWidth-1) + boxSize(1)*(floorCol-1) + floorRow) = (1-a)*(1-b)*c;
            R(boxSize(2)*boxSize(1)*(floorWidth-1) + boxSize(1)*(ceilCol-1) + floorRow) = (1-a)*b*(1-c);
            R(boxSize(2)*boxSize(1)*(floorWidth-1) + boxSize(1)*(floorCol-1) + ceilRow) = a*(1-b)*(1-c);
            R(boxSize(2)*boxSize(1)*(floorWidth-1) + boxSize(1)*(floorCol-1) + floorRow) = (1-a)*(1-b)*(1-c);
        end
    end


%     R = zeros(1,imageSize(1)*imageSize(2));
%     flag = isOutOfBound(row, col, imageSize);
%     
%     if(flag)
%         return
%     else
% 
%         a = row - floor(row);
%         b = col - floor(col);
%         floorRow = floor(row);
%         floorCol = floor(col);   
%         ceilRow = floorRow + 1;
%         ceilCol = floorCol + 1;    
%         
%         if (a == 0 && b == 0)
%             R(imageSize(2)*(col-1) + row) = 1;
%         elseif (a == 0)
%             R(imageSize(2)*(ceilCol-1) + row) = b;
%             R(imageSize(2)*(floorCol-1) + row) = 1-b;
%         elseif (b == 0)
%             R(imageSize(2)*(col-1) + ceilRow) = a;
%             R(imageSize(2)*(col-1) + floorRow) = 1-a;       
%         else        
%             R(imageSize(2)*(ceilCol-1) + ceilRow) = a*b;
%             R(imageSize(2)*(floorCol-1) + ceilRow) = a*(1-b);
%             R(imageSize(2)*(floorCol-1) + floorRow) = (1-a)*(1-b);
%             R(imageSize(2)*(ceilCol-1) + floorRow) = (1-a)*b;
%         end
%     end
end