function y = resampleDip(v,d,S,n,interpolationMethod)
    %Input:
    % v - the water height measurments vector [mm]
    % d - length of robot step [mm]
    % S - Pool area [mm^2]
    % n - number of samples after resampling
    % interpolationMethod - dictates the type of interpolation ('cubic','spline','linear')
    waterHeightDiff = diff(v);
    slicesHeightDiff = waterHeightDiff + d;
    slicesHeightAccumulated = cumsum([0; slicesHeightDiff]);
    volumesAccumulated = cumsum([0; waterHeightDiff*S]);
    figure;
    stem(slicesHeightAccumulated,volumesAccumulated);
    newX = linspace(0,slicesHeightAccumulated(end),n);
    y = interp1(slicesHeightAccumulated,volumesAccumulated,newX,interpolationMethod);
    hold on;
    scatter(newX,y,'fill');
    xlabel('Water Height [mm]','interpreter','latex');
    ylabel('Accumulated slices volume [$\textrm{mm}^3$]','interpreter','latex');
    legend('Original','Resampled');
    
end