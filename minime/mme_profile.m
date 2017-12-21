
function mme_profile(file,args)
    %% MME_PROFILE(file,path,args)
    % renders a profile of a parallelised script/function
    % file : path to the m-file
    % path : where to save the profile
    % args : arguments to the m-file function (if any)
    % see also func_profile
    
    %%  function
    
    % default
    func_default('path','profile_results');
    func_default('args',{});
    
    % restart if on
    status = mpiprofile('status');
    if strcmp(status.ProfilerStatus,'on')
        mpiprofile('off');
    end
    
    % start
    file_rmdir(path);
    profile('on');
    
    % run function
    try
        func_run(file,args);
    catch err
        warning(err.message);
    end
    
    % stop
    mpiprofile('off');
    try %#ok<TRYNC>
        profsave(mpiprofile('info'),path);
    end
end
