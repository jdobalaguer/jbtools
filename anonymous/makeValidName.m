
function N = makeValidName(S)
    %% N = makeValidName(S)
    % like @matlab.lang.makeValidName, except it handles it better
    % the substrings happen to be identical
    
    %% function
    
    % char?
    if ischar(S), N = matlab.lang.makeValidName(S); return; end
    
    % make valid names
    N = reshape(matlab.lang.makeValidName(S(:)),size(S));
    
    % fix conflicts
    u_N = unique(N);
    for i_N = 1:length(u_N)
        x_N = u_N{i_N};
        ii_N = find(strcmp(N,x_N));
        if isscalar(unique(S(ii_N))), continue; end
        [~,~,z_S] = unique(S(ii_N));
        N(ii_N) = arrayfun(@(i)sprintf([x_N,'%d'],i),z_S,'UniformOutput',false);
    end
end
