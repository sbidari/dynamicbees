function X = ind2subVect(siz,ndx)

%   IND2SUBVECT is used to determine the equivalent subscript values
%   corresponding to a given single index into an array.

n = length(siz);
k = [1 cumprod(siz(1:end-1))];
ndx = ndx - 1;
for i = n:-1:1
  X(i) = floor(ndx/k(i))+1;      % replaced "varargout{i}" with "X(i)"
  ndx = rem(ndx,k(i));
end