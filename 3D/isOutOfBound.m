function flag = isOutOfBound(n, m, l, boxSize)
    
    flag = not(floor(n) >= 1 & ceil(n) <= boxSize(1)...
        & floor(m) >= 1 & ceil(m) <= boxSize(2)...
        & floor(l) >= 1 & ceil(l) <= boxSize(3));

end