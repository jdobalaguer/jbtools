
function [z,q] = vec_rows(varargin)
    % [z,q] = VEC_ROWS(x1,x2,..)
    % get unique value for each combination of (x1,x2,..)
    % z = resulting vector
    % q = matrix with the correspondence between z and (x1,x2,..)
    
    %% function
    assertSize(varargin{:});
    assertVector(varargin{:});
    X = cell2mat(cellfun(@mat2vec,varargin,'UniformOutput',false));
    [q,~,z] = unique(X,'rows');
    z = reshape(z,size(varargin{1}));
end
