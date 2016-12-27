function B = generateBox(s)

    B = zeros(s,s,s);
    p = 0.5;
    i_1 = 1 + ceil(s*(1-p)/2);
    i_2 = s - ceil(s*(1-p)/2);
    range = i_1:i_2;
    
    B(range, range, range) = 1;
    
end