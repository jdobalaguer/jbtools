
function mturk_parseall_parse(pathname,allfiles,i_allfiles)
    nb_allfiles = length(allfiles);
    
    %% parse data
    filename = [pathname,filesep,allfiles(i_allfiles).name];
    % SKIP
    if exist([filename,'.parse.mat'],'file')
        % print it
        fprintf('mturk_parseall: PARSE  file "%s" : %03i / %03i (skip) \n',filename,i_allfiles,nb_allfiles);
    % PARSE
    else
        try
            % print it
            fprintf('mturk_parseall: PARSE  file "%s" : %03i / %03i \n',filename,i_allfiles,nb_allfiles);
            % read and parse
            data = struct();
            data = mturk_parsefile(filename);
            % save
            save([filename,'.parse.mat'],'data');
        catch err
            % ERROR
            % rethrow
            rethrow(err);
            % print
            fprintf('mturk_parseall: WARNING. error while parsing "%s"\n',allfiles(i_allfiles).name);
            % mkdir
            if ~exist([pathname,'_error'],'dir'); mkdir([pathname,'_error']); end
            % move file
            movefile(filename,[pathname,'_error',filesep,allfiles(i_allfiles).name]);
        end
    end    
end