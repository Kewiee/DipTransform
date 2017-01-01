%% Contents.m
%
% These codes implement and test the hybrid LSMR method described in
%   "A Hybrid LSMR Algorithm for Large-Scale Tikhonov Regularization"
%       - Chung and Palmer, 2015
%
%   Run startup_hyLSMR.m to access subfolders.
%   
% ---------- Subfolders: -------------------------------------------------
%
%   RestoreTools - Nagy's RestoreTools package for test data (grain and
%                   satellite) and for psfMatrix 
%   HyBR         - Hybrid Bidiagonalization Regularization codes
%   LSMR_LSQR    - Original and modified LSMR and LSQR codes from Fong and
%                   Saunders
%
%
% ---------- Scripts: -------------------------------------------------
%
%   Example_HyBR_lsmr - This script sets up an image deblurring problem 
%                       and uses HyBR_lsmr with various parameter selection 
%                       methods.  This is a simple example for first-time 
%                       users to illustrate how to use HyBR_lsmr codes.
%
%   testLSQRvsLSMR.m - This script compares LSMR and LSQR for the grain 
%                      deblurring example.  It produces convergence plots 
%                      for relative errors and |A'r_k| per iteration.  
%                      This corresponds to Fig 3.1 in the paper.
%   
%   svdCompare.m     - This script compares 
%                         singular values of A (original matrix)
%                         singular values of LSMR submatrix \hat B_k, \hat s_k
%                         eigenvalues of B_k'B_k, s_k^2
%                         singular values of the GK bidiagonal matrix B_k, s_k
%                      This corresponds to Fig 3.2 in the paper.
%
%   Example1_Sat_5   - This script compares relative error plots for the 
%                       following reconstruction methods:
%                         (1) LSQR
%                         (2) hybrid LSQR with optimal regularization parameter
%                         (3) LSMR
%                         (4) hybrid LSMR with optimal regularization parameter
%                      Then various regularization parameter methods are
%                      compared. These correspond to some of the numerical 
%                      results in the paper.
%
%
% J. Chung and K. Palmer, 2015