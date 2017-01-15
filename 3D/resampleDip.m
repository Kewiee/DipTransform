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
    %figure;
    %stem(slicesHeightAccumulated,volumesAccumulated,'fill');
    newX = linspace(0,slicesHeightAccumulated(end),n);
    y = interp1(slicesHeightAccumulated,volumesAccumulated,newX,interpolationMethod);
    %hold on; plot(newX,y,'LineWidth',2,'color',[0 0.5 0]);
    %hold on; scatter(newX,y,'r','o');
    %xlabel('Accumulated height [mm]','interpreter','latex');
    %ylabel('Accumulated volume [$\textrm{mm}^3$]','interpreter','latex');
    %h = legend('Original','Continuous','Resampled');
    %set(h,'FontSize',16);
    %set(gca,'cameraupvector',[1 0 0]);
    %axis ij;
end