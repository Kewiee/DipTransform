%% svdCompare.m
%
% This code was used to generate Figure 3.2 in the paper:
%   "A Hybrid LSMR Algorithm for Large-Scale Tikhonov Regularization"
%       - Chung and Palmer, 2015
%
% This script compares at various iterations:
%    (1) singular values of A (original matrix)
%    (2) singular values of LSMR matrix \hat B_k, \hat s_k
%    (3) eigenvalues of B_k'B_k, s_k^2
%    (4) singular values of the GK bidiagonal matrix B_k, s_k
%
% Chung and Palmer, 2014

%   Generate Test Problem (truth data)
[A, b_true, x_true] = heat(256); % From Per Christian Hansen's REGU toolbox

%   Add white noise to get b = A*x_true + N
N = WhiteNoise(b_true,.1);
b = b_true + N;
maxit = 50;

%% LSMR - our implementation
input = HyBR_lsmrset('InSolv', 'none', 'x_true', x_true,'Iter', maxit);
[x, output_lsmr] = HyBR_lsmr(A, b,input);
B = output_lsmr.B;

%% Display
close all
figure(1), axes('FontSize', 18)
s = svd(A);
semilogy(s(1:maxit-4),'r','LineWidth', 2), hold on

for i = 1:5:maxit
  Btemp = B(1:i+1,1:i);
  alphakp1 = B(i+1,i+1);
  betabarkp1 = alphakp1*B(i+1,i);
  Bhat = [Btemp'*Btemp; zeros(1,i-1),betabarkp1];
  
  s = svd(Bhat);
  plot(s,'bo-','MarkerSize', 8)

  s = svd(Btemp);
  plot(s.^2,'m*-','MarkerSize', 8)

  plot(s,'ks-')
end
axis([1, 46, 10^-7, 10^1])
h = legend('$\sigma_i$', '$\hat{s}_i$', '$s_i^2$','$s_i$');
set(h,'Interpreter','latex')
xlabel('iterations ')
axis([1,46,10^-7,1])