
function mme_open(n)
    %% MME_OPEN([n])
    % open the parallel pool
    % n : number of workers (default 50)

    %% function
    if ~exist('gcp','file'), return; end
    
    % open pool
    func_default('n',50);
    c = parcluster();
    c.NumWorkers = n;
    parpool(c,n);
end
