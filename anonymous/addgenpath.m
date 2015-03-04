
function addgenpath(path)
    %% ADDGENPATH(path)
    
    %% warnings
    
    %% function
    if isrelative(path)
        path = [pwd(),filesep(),path];
    end
    addpath(genpath(path));
end