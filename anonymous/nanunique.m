
function varargout = nanunique(varargin)
    %% nanunique
    % similar to "unique", but works with nans
    % [C,IA,IC] = nanunique(A)            -normal behaviour (same as 'sorted')
    % [C,IA,IC] = nanunique(A,'stable')   -without sorting
    % [C,IA,IC] = nanunique(A,'rows')     -unique rows in a matrix
    % [C,IA,IC] = nanunique(A,OCCURRENCE) -specify the index to be returned in IA
    % [C,IA,IC] = nanunique(A,'legacy')   -use the old version of unique
    
    %% function
    
    % assert inf
    assert(~any(isinf(varargin{1}(:))), 'nanunique: error. this function doesn''t allow Inf values');
    
    % replace nan with inf
    varargin{1}(isnan(varargin{1}(:))) = inf;
    
    % unique
    [varargout{1:nargout}] = unique(varargin{:});
    
    % replace inf with nan
    varargout{1}(isinf(varargout{1}(:))) = nan;
end
