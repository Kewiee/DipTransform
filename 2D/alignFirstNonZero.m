function slices = alignFirstNonZero(slices)

    firstNonZero = find(slices,1);
    slices = circshift(slices, -firstNonZero+2);

end