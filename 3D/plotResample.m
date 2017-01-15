clc; clear; close all;

load ball200Sample.mat;

vec = 1:6;
vec = 0.5*[vec.^2, fliplr(vec).^2];
v = cumsum(vec)';
resolution = 20;
S = 440*270;
factor = 1;
d = 2*factor;
BBlength = v(end)+d*length(v);

ball200Sample = ball200Sample(1:factor:end);
sliceToAlgorithm = resampleAlignAndSmooth(v, resolution, d, S, BBlength,0,0);





