function mturk_parseall(pathname)

    %% directories
    allfiles = mturk_parseall_dirs(pathname);
    nb_allfiles = length(allfiles);
    
    %% parse data
    parfor (i_allfiles = 1:nb_allfiles, mme_size())
        mturk_parseall_parse(pathname,allfiles,i_allfiles);
    end
    fprintf('mturk_parseall: \n');
    
    %% uncell data
    parfor (i_allfiles = 1:nb_allfiles, mme_size())
        mturk_parseall_uncell(pathname,allfiles,i_allfiles);
    end
    fprintf('mturk_parseall: \n');
    
    %% concatenate data
    if nb_allfiles<2; return; end
    mturk_parseall_concat(pathname,allfiles);
    
end