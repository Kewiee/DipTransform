function B = dippingPreprocessing(A)

    pad = 210;
    B = padarray( not(im2bw(A,0.1)), [pad pad] );
    B = completeingToSquare(B);
    B = imresize(B, [100 100]);
    B = im2bw(B, 0.1);
end

