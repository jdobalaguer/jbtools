
function r = ranger(x)
    %% r = RANGER(x)
    
    %% function
    x = mat2vec(x);
    r = [nanmin(x),nanmax(x)];
end
