
function assertFile(file)
    %% ASSERTFILE(file)
    
    %% warnings
    %#ok<*EXIST>
    
    %% function
    b = (exist(file,'file') == 2);
    c = caller();
    if isempty(c), c = 'assertExist'; end
    assert(b,'%s: error. "%s" doesnt exist',c,file);

end
