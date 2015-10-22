
function mturk_geturl(path,url)
    %% create path
    file_mkdir(path);
    
    %% list files
    index   = urlread(url);
    u_file  = unique(regexp(index,'\w*.txt','match'));
    nb_file = length(u_file);
    
    %% get files
    downloaded = 0;
    for i_file = 1:length(u_file)
        urlfile  = [url, filesep,u_file{i_file}];
        pathfile = [path,filesep,u_file{i_file}];
        if ~exist(pathfile,'file')
            urlwrite(urlfile,pathfile);
            downloaded = downloaded + 1;
        end
    end
    
    %% fprintf
    fprintf('mturk_geturl: downloaded %d files\n',downloaded);
end