
function mturk_parseurl(path_file,path_url)
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