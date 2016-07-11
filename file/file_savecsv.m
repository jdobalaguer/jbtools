
function file_savecsv(path,c,dlm)
%% FILE_SAVECSV(path,c,dlm)
% Writes cell array content into a *.csv file.
%
% path  : Name of the file to save. [ i.e. 'text.csv' ]
% c     : Cell with the data to save
% dlm   : Seperating sign, normally:',' (default)

%% Notes
% this file was originally called "cell2csv"
% and is written by Sylvain Fiedler, KA, 2004
% modified by Rob Kohr, Rutgers, 2005 - changed to english and fixed delimiter
% (modified now to integrate with jbtools)

%% function

    % default
    func_default('dlm',',');

    % open file
    fid = fopen(path,'w');

    try
        for i = 1:size(c,1)
            for j = 1:size(c,2)

                % get value
                var = c{i,j};
                if isempty(var),   var = '';           end
                if isnumeric(var), var = num2str(var); end

                % write to file
                fprintf(fid,var);

                % add delimiter or EOL
                d = dlm;
                if j == size(c,2), d = '\n'; end
                if any([i,j]<size(c)), fprintf(fid,d); end
            end
        end

        % close
        fclose(fid);

    catch err
        % close file and throw error
        fclose(fid);
        rethrow(err);
    end
end
