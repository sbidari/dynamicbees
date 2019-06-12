function X = cartprod(varargin)
%CARTPROD Cartesian product of multiple sets.
%
%   This function requires IND2SUBVECT, also available on the MathWorks 
%   File Exchange site.

numSets = length(varargin);
for i = 1:numSets
    thisSet = sort(varargin{i});
    if ~isequal(numel(thisSet),length(thisSet))
        error('All inputs must be vectors.')
    end
    if ~isnumeric(thisSet)
        error('All inputs must be numeric.')
    end
    if ~isequal(thisSet,unique(thisSet))
        error(['Input set' ' ' num2str(i) ' ' 'contains duplicated elements.'])
    end
    sizeThisSet(i) = length(thisSet);
    varargin{i} = thisSet;
end
X = zeros(prod(sizeThisSet),numSets);
for i = 1:size(X,1)
    
    ixVect = ind2subVect(sizeThisSet,i);
    
    for j = 1:numSets
        X(i,j) = varargin{j}(ixVect(j));
    end
end