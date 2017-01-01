%% Hybrid LSMR Codes Startup file

directory = pwd;
path(directory, path)

% RestoreTools - Jim Nagy
path([directory, '/RestoreTools/Classes'], path)
path([directory, '/RestoreTools/DirectMethods'], path)
path([directory, '/RestoreTools/Examples'], path)
path([directory, '/RestoreTools/IterativeMethods'], path)
path([directory, '/RestoreTools/TestData'], path)

% LSMR and LSQR original and modified codes
path([directory, '/LSMR_LSQR'], path)

% Hybrid LSQR and LSMR codes
path([directory, '/HyBR'], path)

clear
clc