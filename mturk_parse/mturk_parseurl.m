
function mturk_parseurl(path,url)
    %% get url
    mturk_geturl(path,url);
    
    %% parse data
    mturk_parseall(path);
    
end