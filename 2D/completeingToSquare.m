function B = completeingToSquare(B)

    sizes = size(B);
    if(mod(sizes(1),2)~=0)
        B = B(1:(sizes(1)-1),:);
    end
    if(mod(sizes(2),2)~=0)
        B = B(:,1:(sizes(2)-1));
    end
    
    sizes = size(B);
    pad = ceil(abs(sizes(1) - sizes(2))/2);
    zero = zeros(max(sizes),pad);
    if (sizes(1) > sizes(2))
        B = [zero, B, zero];
    elseif (sizes(2) > sizes(1))
        B = [zero'; B; zero'];  
    end
    
end