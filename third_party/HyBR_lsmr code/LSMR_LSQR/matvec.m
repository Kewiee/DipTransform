function b = matvec( A,mode,x);
%
%  This function does a matrix vector multiplication
%
%
if mode == 1
  b = A*x;
else
  b = A'*x;
end