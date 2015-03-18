
function [z,q] = get_rows(varargin)
    % [z,q] = GET_ROWS(x1,x2,..)
    % get unique value for each combination of (x1,x2,..)
    % z = resulting vector
    % q = matrix with the correspondence between z and (x1,x2,..)
    
    %% warnings
    
    %% function
    assertSize(varargin{:});
    assertFunc(@isvector,varargin{:});
    X = nan(length(varargin{1}),length(varargin));
    for i = 1:nargin, X(:,i) = varargin{i}; end
    [q,~,z] = unique(X,'rows');

end