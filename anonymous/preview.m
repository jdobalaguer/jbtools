
function preview(path)
    %% PREVIEW(path)
    % preview something with a mac
    
    %% function
    path = file_match(path);
    if ~isunix(),     error('preview: error. only for mac'); end
    if isempty(path), error('preview: error. file not found'); end
    
    % preview
    evalc(sprintf('!qlmanage -p "%s"',path));
end
