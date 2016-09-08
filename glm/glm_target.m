
function y = glm_target(s,m)
    %% y = GLM_TARGET(s,m)
    % Build the target vectors
    % 
    % s : struct          : data
    % m : struct          : model
    % y : cell of vectors : target
    
    %% function
    
    % default model
    m = struct_default(m,glm_model());
    
    % subject stuff
    x_subject = s.(m.subject);
    [u_subject,n_subject] = numbers(x_subject);
    
    % get target across subjects
    x_target = s.(m.target);
    assertVector(x_target)
    x_target = mat2vec(x_target);

    % create target vectors
    y = cell(n_subject,1);
    for i_subject = 1:n_subject
        ii_subject = (x_subject == u_subject(i_subject));
        y{i_subject} = x_target(ii_subject,:);
        if m.zscore, y{i_subject} = nan2zero(mat_zscore(y{i_subject},1)); end
    end
end
