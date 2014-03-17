
function mturk_parseall_uncell(pathname,allfiles,i_allfiles)
    nb_allfiles = length(allfiles);
    
    filename = [pathname,filesep,allfiles(i_allfiles).name];
    if exist([filename,'.uncell.mat'],'file')
        %% skip
        % print it
        fprintf('mturk_parseall: UNCELL file "%s" : %03i / %03i (skip)\n',filename,i_allfiles,nb_allfiles);
    elseif ~exist([filename,'.parse.mat'],'file')
        %% error
        % print it
        fprintf('mturk_parseall: UNCELL file "%s" : %03i / %03i (not parsed)\n',filename,i_allfiles,nb_allfiles);
    else
        %% uncell
        try
            % print it
            fprintf('mturk_parseall: UNCELL file "%s" : %03i / %03i \n',filename,i_allfiles,nb_allfiles);
            % load
            data = struct();
            load([filename,'.parse.mat'],'data');
            % read and parse
            data = mturk_uncell(data);
            % save
            save([filename,'.uncell.mat'],'data');
        catch
            fprintf('mturk_parseall: WARNING. error while uncelling "%s" \n',allfiles(i_allfiles).name);
        end
    end
end
