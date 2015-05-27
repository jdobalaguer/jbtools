
function addgenpath(path)
    %% ADDGENPATH(path)
    
    %% warnings
    
    %% function
    path = file_rel2abs(path);
    addpath(genpath(path));
end