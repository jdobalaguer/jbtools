
function s = mme_size()
    %% s = MME_SIZE()
    % open the parallel pool
    % s : number of workers

    %% function
    s = 0;
    if ~exist('gcp','file'), return; end
    
    % open pool
    poolobj = gcp('nocreate'); % If no pool, do not create new one.
    if ~isempty(poolobj)
        s = poolobj.NumWorkers;
    end
end
