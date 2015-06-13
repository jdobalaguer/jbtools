
function rmgenpath(path)
    %% RMGENPATH(path)
    
    %% warnings
    
    %% function
    path = file_2absolute(path);
    rmpath(genpath(path));
end