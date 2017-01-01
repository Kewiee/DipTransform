% Example1_Sat_5.m
%
% This script computes reconstructions for the satellite example for 5%
% noise level.
%
% First we compare the following reconstruction methods:
%     (1) LSQR
%     (2) hybrid LSQR using the optimal regularization parameter
%     (3) LSMR
%     (4) hybrid LSMR using the optimal regularization parameter
%
% Then we compare various regularization parameter methods for the hybrid
% LSMR method.
%   (1)  LSMR (no regularization)
%   (2)  hybrid LSMR using optimal parameter
%   (3)  hybrid LSMR using GCV
%   (4)  hybrid LSMR using DP
%
% This code was used to generate the figures in Example 1 of the paper:
%   "A Hybrid LSMR Algorithm for Large-Scale Tikhonov Regularization"
%       - Chung and Palmer (2015)

% Set a seed for the random generator
rng(0) 

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
figure,imshow(b,[]), title('Blurred Image')
figure,imshow(PSF,[]), title('Point Spread Function (PSF)')

%% Begin Reconstructions
maxit = 150;
% LSQR
input = HyBRset('InSolv', 'none', 'x_true', x_true(:),'Iter', maxit,'Reorth','on');
[~, output_lsqr] = HyBR(A, b, [],input);

% LSMR
input = HyBR_lsmrset('InSolv', 'none', 'x_true', x_true(:),'Iter', maxit,'Reorth','on');
[~, output_lsmr] = HyBR_lsmr(A, b, input);

% Hybrid LSQR - optimal param
input = HyBRset('RegPar','optimal', 'x_true', x_true,'Iter', maxit, 'Reorth','on');
[~, output_hylsqr_opt] = HyBR(A, b, [],input);

% Hybrid LSMR - optimal param
input = HyBR_lsmrset('RegPar','optimal', 'x_true', x_true,'Iter', maxit, 'Reorth','on');
[~, output_hylsmr_opt] = HyBR_lsmr(A, b, input);

% Plot relative errors
figure, axes('FontSize', 18),
plot([1;output_lsqr.Enrm],'bs-', 'LineWidth', 2,'MarkerSize',8),hold on
plot([1;output_hylsqr_opt.Enrm],'b--', 'LineWidth', 2)
plot([1;output_lsmr.Enrm],'ro-', 'LineWidth', 2,'MarkerSize',8)
plot([1;output_hylsmr_opt.Enrm],'r-', 'LineWidth', 2)
legend('LSQR','hybrid LSQR-opt','LSMR','hybrid LSMR-opt')
xlabel('iterations')
ylabel('relative error')
axis([0,maxit,.3,.6])

%% Next compare various parameter selection methods
% Hybrid LSMR - GCV
input = HyBR_lsmrset('RegPar','gcv', 'x_true', x_true,'Iter', maxit, 'Reorth','on');
[x_lsmr_gcv, output_lsmr_gcv] = HyBR_lsmr(A, b,input);

% Hybrid LSMR - DP
input = HyBR_lsmrset('RegPar','dp', 'x_true', x_true,'Iter', maxit, 'Reorth','on');
[x_lsmr_dp, output_lsmr_dp] = HyBR_lsmr(A, b,input);

% Hybrid LSQR - WGCV
input = HyBRset('x_true', x_true,'Iter', maxit, 'Reorth','on');
[x_lsqr_wgcv, output_lsqr_wgcv] = HyBR(A, b, [],input);

% Plot relative errors 
figure, axes('FontSize', 18),
plot([1;output_lsmr.Enrm],'ro-','LineWidth',2,'MarkerSize',8),hold on
plot([1;output_hylsmr_opt.Enrm],'r-', 'LineWidth', 2)
plot([1;output_lsmr_dp.Enrm],':','Color',[0 .5 0],'LineWidth',6)
plot([1;output_lsmr_gcv.Enrm],'k--', 'LineWidth', 2)
plot([1;output_lsqr_wgcv.Enrm], 'm^')

miniteration_sgcv_5 = output_lsmr_gcv.iterations;
miniteration_sdp_5 = output_lsmr_dp.iterations;
plot(miniteration_sgcv_5+1,output_lsmr_gcv.Enrm(miniteration_sgcv_5),'k*','MarkerSize', 14, 'LineWidth',2)
plot(miniteration_sdp_5+1,output_lsmr_dp.Enrm(miniteration_sdp_5),'*','Color',[0 .5 0],'MarkerSize',14, 'LineWidth',2)
legend('LSMR','hybrid LSMR-opt','hybrid LSMR-DP','hybrid LSMR-GCV','hybrid LSQR-WGCV')
xlabel('iterations')
axis([0,maxit,.3,.7])
ylabel('relative error')

% Display image reconstructions
figure,imshow(x_lsmr_gcv,[]),
title(sprintf('hybrid LSMR with GCV: %d iterations, alpha=%.2e',output_lsmr_gcv.iterations,output_lsmr_gcv.alpha))

figure,imshow(x_lsmr_dp,[]),
title(sprintf('hybrid LSMR with DP: %d iterations, alpha=%.2e',output_lsmr_dp.iterations,output_lsmr_dp.alpha))

figure,imshow(x_lsqr_wgcv,[]),
title(sprintf('hybrid LSQR with WGCV: %d iterations, alpha=%.2e',output_lsqr_wgcv.iterations,output_lsqr_wgcv.alpha))

