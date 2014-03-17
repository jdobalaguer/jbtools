
function allfiles = mturk_parseall_dirs(pathname)
    %% directories
    % dir files
    allfiles = dir([pathname,filesep,'*.txt']);
    
    % remove directories
    i_allfiles = 1;
    while i_allfiles <= length(allfiles)
        if allfiles(i_allfiles).name(1)=='.'
            allfiles(i_allfiles) = [];
        else
            i_allfiles = i_allfiles+1;
        end
    end
end
