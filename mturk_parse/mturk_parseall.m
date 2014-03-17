function mturk_parseall(pathname)

    %% parallel
    jb_parallel_start;
    
    %% directories
    allfiles = mturk_parseall_dirs(pathname);
    nb_allfiles = length(allfiles);
    
    %% parse data
    parfor i_allfiles = 1:nb_allfiles
        mturk_parseall_parse(pathname,allfiles,i_allfiles);
    end
    fprintf('mturk_parseall: \n');
    
    %% uncell data
    parfor i_allfiles = 1:nb_allfiles
        mturk_parseall_uncell(pathname,allfiles,i_allfiles);
    end
    fprintf('mturk_parseall: \n');
    
    %% concatenate data
    if nb_allfiles<2; return; end
    mturk_parseall_concat(pathname,allfiles);
    
    %% parallel
    jb_parallel_stop;

end