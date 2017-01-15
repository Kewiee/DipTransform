function S = sumZplains(boxSize)

    S = zeros(boxSize(1),boxSize(1)*boxSize(2)*boxSize(3));
    for i = 1:boxSize(3)
        for j = 1:(boxSize(1)*boxSize(2))    
            S(i,(i-1)*boxSize(1)*boxSize(2)+j) = 1;
        end
    end
%     S = zeros(boxSize(1),boxSize(1)*boxSize(2)*boxSize(3));
%     for i = 1:boxSize(1)
%         for j = 1:(boxSize(2)*boxSize(3))    
%             S(i,boxSize(1)*(j-1)+i) = 1;
%         end
%     end

    

end