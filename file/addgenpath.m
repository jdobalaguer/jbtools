
function addgenpath(path)
    %% ADDGENPATH(path)
    
    %% warnings
    
    %% function
    path = file_2absolute(path);
    addpath(genpath(path));
end