
function rmgenpath(path)
    %% RMGENPATH(path)
    
    %% warnings
    
    %% function
    path = file_rel2abs(path);
    rmpath(genpath(path));
end