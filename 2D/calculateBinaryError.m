function E = calculateBinaryError(I,B)

    E = 100*sum(sum(abs(I - B)))/(size(I,1)*size(I,2));
    
end