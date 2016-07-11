
function c = file_loadcsv(path,dlm)
%% c = FILE_LOADCSV(path,dlm)
% Reads cell array content from a *.csv file.
%
% path  : Name of the file to save. [ i.e. 'text.csv' ]
% c     : Cell with the data to save
% dlm   : Seperating sign, normally:',' (default)

%% function

    % default
    func_default('dlm',',');

    % open file
    fid = fopen(path,'r');

    try
        % read file
        c = {};
        while true
            line       = fgetl(fid);
            if ~ischar(line), break; end
            c{end+1,1} = strsplit(line,dlm); %#ok<AGROW>
        end

        % close
        fclose(fid);
        
    catch err
        % close file and throw error
        fclose(fid);
        rethrow(err);
    end
    
    % flatten CSV if possible
    c = cat(1,c{:});
    
    % transform to numbers if possible
    m = cellfun(@str2double,c);
    c(~isnan(m)) = num2cell(m(~isnan(m)));
end
