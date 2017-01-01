% testLSQRvsLSMR.m
% 
% This code was used to generate Figure 3.1 in the paper:
%   "A Hybrid LSMR Algorithm for Large-Scale Tikhonov Regularization"
%       - Chung and Palmer, 2015
%
% Here we use the grain example to compare convergence of relative errors
% and values |A'r_k| 

load Grain
center = [129, 129];
A = psfMatrix(PSF, center, 'periodic');

b = A*x_true;
n = WhiteNoise(b, .01);
b = b+n;

%% First run LSMR and compute relative errors at each iteration
atol      = 1.0e-7;
btol      = 1.0e-7;
conlim    = 1.0e+10;
itnlim    = 256;
show      = 0;

lambda = 0;

[ x, Xall, istop, itn, normr, normar ] ...
  = lsmr_mod( @(x,mode)matvec(A,mode,x), b(:), lambda, atol, btol, conlim, itnlim, 0, show );

rerr = zeros(itnlim,1);
res = zeros(itnlim,1);
Ares = zeros(itnlim,1);
for i=1:itnlim
  rerr(i) = norm(Xall(:,i)-x_true(:))/norm(x_true(:));
  res(i) = norm(A*Xall(:,i)-b(:));
Ares(i) = norm(A'*(A*Xall(:,i)-b(:)));
end

%% Next run LSQR and compute relative errors at each iteration

[ x, Xall_lsqr, istop, itn, r1norm, r2norm, anorm, acond, arnorm, xnorm, var ]...
  = lsqr_mod(size(A,1), size(A,2), @(x,mode)matvec(A,mode,x), b(:), lambda, atol, btol, conlim, itnlim, show );

rerr_lsqr = zeros(itnlim,1);
res_lsqr = zeros(itnlim,1);
Ares_lsqr = zeros(itnlim,1);
for i=1:itnlim
  rerr_lsqr(i) = norm(Xall_lsqr(:,i)-x_true(:))/norm(x_true(:));
  res_lsqr(i) = norm(A*Xall_lsqr(:,i)-b(:));
  Ares_lsqr(i) = norm(A'*(A*Xall_lsqr(:,i)-b(:)));
end

%% Display plots
figure, axes('FontSize', 18),
plot(rerr, 'LineWidth', 2)
hold on, plot(rerr_lsqr,'k--', 'LineWidth', 2)
legend('LSMR','LSQR')
xlabel('iterations')
ylabel('relative error')
axis([0,250,.1,1])

figure, axes('FontSize', 18),
semilogy(res, 'LineWidth', 2)
hold on, semilogy(res_lsqr,'k--', 'LineWidth', 2)
legend('LSMR','LSQR')
xlabel('iterations')
ylabel('||r_k||_2')
axis([0,250,.1,10])

figure, axes('FontSize', 18),
semilogy(Ares, 'LineWidth', 2)
hold on, semilogy(Ares_lsqr,'k--', 'LineWidth', 2)
legend('LSMR','LSQR')
xlabel('iterations')
ylabel('||A^T r_k||_2')
axis([0,250,1e-4,10])