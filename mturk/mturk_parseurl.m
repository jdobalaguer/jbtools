
function mturk_parseurl(path_file,path_url)
    % mturk_parseurl(path_file,path_url)
    % example:
    %   mturk_parseurl('data_folder','http://185.47.61.11/main/tasks/jan/151022/data/');
    
    if path_file(end)=='/', path_file(end) = []; end
    if path_url(end)=='/',  path_url(end) = [];  end
    
    %% set paths
    url = {};
    url{1} = [path_url,'/data'];
    url{2} = [path_url,'/tmp'];
    file = {};
    file{1} = [path_file,'/data'];
    file{2} = [path_file,'/tmp'];
    
    %% get url
    mturk_geturl(file{1},url{1});
    mturk_geturl(file{2},url{2});

    %% parse data
    mturk_parseall(file{1});
    
end