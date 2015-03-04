
function mturk_parseall_concat(pathname,allfiles)
    nb_allfiles = length(allfiles);
    
    %% print
    fprintf('mturk_parseall: CONCAT all uncelled files\n');
    
    %% load
    alldata = {};
    for i_allfiles = 1:nb_allfiles
        filename = [pathname,filesep,allfiles(i_allfiles).name];
        % skip
        if ~exist([filename,'.uncell.mat'],'file')
            % print it
            fprintf('mturk_parseall: file "%s" : %03i / %03i (not uncelled)\n',filename,i_allfiles,nb_allfiles);
        % load
        else
            data = struct();
            load([filename,'.uncell.mat'],'data');
            alldata{end+1} = data;
        end        
    end
    
    %% concatenate
    alldata = mturk_concatall(alldata);
    
    %% save
    save([pathname,filesep,'alldata.mat'],'alldata');

    %% print
    fprintf('mturk_parseall: \n');
end