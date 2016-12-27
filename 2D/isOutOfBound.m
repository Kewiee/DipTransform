function flag = isOutOfBound(row, col, imageSize)
    
    flag = not(floor(row) >= 1 & ceil(row) <= imageSize(1) & floor(col) >=1 & ceil(col) <= imageSize(2));

end