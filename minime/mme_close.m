
function mme_close()
    %% MME_CLOSE()
    % close the parallel pool

    %% function
    if ~exist('gcp','file'), return; end
    
    % close pool
    delete(gcp());
end
