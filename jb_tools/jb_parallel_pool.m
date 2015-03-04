
function n_pool = jb_parallel_pool()
    %% n_pool = JB_PARALLEL_POOL()
    % return the size of the parallel pool
    % 0 if the distcomp toolbox is not available
    
    %% warnings
    
    %% function
    if ~exist('matlabpool','file')
        n_pool = 0;
    else
        n_pool = matlabpool('size');
    end
end