function a = poslin(n,b) 
%POSLIN Positive linear transfer function. 
%	 
%	POSLIN(N) 
%	  N - SxQ Matrix of net input (column) vectors. 
%	Returns the values of N squashed between -1 an 1. 
%	 
%	EXAMPLE: n = -10:0.1:10; 
%	         a = poslin(n); 
%	         plot(n,a) 
%	 
%	POSLIN(Z,B) ...Used when Batching. 
%	  Z - SxQ Matrix of weighted input (column) vectors. 
%	  B - Sx1 Bias (column) vector. 
%	Returns the squashed net input values found by adding 
%	  B to each column of Z. 
 
% Mark Beale, 1-31-92 
% Revised 12-15-93, MB 
% Copyright (c) 1992-94 by The MathWorks, Inc. 
% $Revision: 1.1 $  $Date: 1994/01/11 16:29:26 $ 
 
if nargin < 1, error('Not enough arguments.'); end 
 
if nargin==2 
  [nr,nc] = size(n); 
  n = n + b*ones(1,nc); 
end 
a = n .* (n > 0); 