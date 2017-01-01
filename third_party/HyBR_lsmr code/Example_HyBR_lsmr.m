%% Example_HyBR_lsmr.m
%
% This script provides an example that uses HyBR_lsmr.m, which is a 
%     hybrid LSMR algorithm that is described in
%
%   "A Hybrid LSMR Algorithm for Large-Scale Tikhonov Regularization"
%       - Chung and Palmer, SISC 2015
%
%   The structure of HyBR_lsmr is based on HyBR code of Chung and Nagy that
%   implements a hybrid LSQR approach.
%
% Chung and Palmer, 2015

% Set a seed for the random generator
rng(0) 
addpath(genpath(('./')));

% Problem setup - deblurring example from RestoreTools
load satellite
center = [129, 129];
A = psfMatrix(PSF, center, 'reflexive');
b_true = A*x_true;

%  Add noise
[N,alpha] = WhiteNoise(b_true,0.05);
b = b_true + N;

% Display images
figure,imshow(x_true,[]), title('True Image')
figure,imshow(b,[]), title('Observed, Blurred Image')
figure,imshow(PSF,[]), title('Point Spread Function (PSF)')

%% Use various parameter selection methods to get a hybrid LSMR reconstruction
maxit = 100;

% Hybrid LSMR - GCV
input = HyBR_lsmrset('RegPar','gcv', 'Iter', maxit, 'Reorth','on');
[x_lsmr_gcv, output_lsmr_gcv] = HyBR_lsmr(A, b,input);
figure,imshow(x_lsmr_gcv,[]), 
title(sprintf('Reconstruction with GCV: %d iterations, alpha=%.2e',output_lsmr_gcv.iterations,output_lsmr_gcv.alpha))

% Hybrid LSMR - Discrepancy Principle
input = HyBR_lsmrset('RegPar','dp','Iter', maxit, 'Reorth','on');
[x_lsmr_dp, output_lsmr_dp] = HyBR_lsmr(A, b,input);
figure,imshow(x_lsmr_dp,[]), 
title(sprintf('Reconstruction with DP: %d iterations, alpha=%.2e',output_lsmr_dp.iterations,output_lsmr_dp.alpha))

% Hybrid LSMR - Optimal regularization parameter
input = HyBR_lsmrset('RegPar','optimal', 'x_true', x_true, 'Iter', maxit, 'Reorth','on');
[x_lsmr_opt, output_lsmr_opt] = HyBR_lsmr(A, b,input);
figure,imshow(x_lsmr_opt,[]), 
title(sprintf('Reconstruction with Optimal: %d iterations, alpha=%.2e',output_lsmr_opt.iterations,output_lsmr_opt.alpha))