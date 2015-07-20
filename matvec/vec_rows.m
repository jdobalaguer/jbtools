
function [z,q] = vec_rows(varargin)
    % [z,q] = VEC_ROWS(x1,x2,..)
    % get unique value for each combination of (x1,x2,..)
    % z = resulting vector
    % q = matrix with the correspondence between z and (x1,x2,..)
    % see also GRP2IDX
    
    %% function
    assertSize(varargin{:});
    assertVector(varargin{:});
    X = cellfun(@mat2vec,varargin,'UniformOutput',false);
    X = cellfun(@double, varargin,'UniformOutput',false);
    X = cell2mat(X);
    [q,~,z] = unique(X,'rows');
    z = reshape(z,size(varargin{1}));
end
