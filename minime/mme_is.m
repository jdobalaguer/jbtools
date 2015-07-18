
function b = mme_is()
    %% b = MME_IS()
    % is this the supercomputer?
    
    %% function
    b = isunix() && strcmp(evalc('!hostname'),['minime',10]);
end
