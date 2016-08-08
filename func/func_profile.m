
function func_profile(file,path,args)
    %% FUNC_PROFILE(file,path,args)
    % renders a profile of a script/function
    % file : path to the m-file
    % path : where to save the profile
    % args : arguments to the m-file function (if any)
    
    %%  function
    
    % default
    func_default('path','profile_results');
    func_default('args',{});
    
    % restart if on
    status = profile('status');
    if strcmp(status.ProfilerStatus,'on')
        profile('off');
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
    profile('off');
    try %#ok<TRYNC>
        profsave(profile('info'),path);
    end
end
