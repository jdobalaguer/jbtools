
function rmdirp(path)
    if ~exist(path,'dir'); return; end
    rmdir(path,'s');
end

