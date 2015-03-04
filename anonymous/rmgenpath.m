
function rmgenpath(path)
    %% RMGENPATH(path)
    
    %% warnings
    
    %% function
    if isrelative(path)
        path = [pwd(),filesep(),path];
    end
    rmpath(genpath(path));
end