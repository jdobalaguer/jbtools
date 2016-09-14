
function x = glm_design(s,m)
    %% x = GLM_DESIGN(s,m)
    % Build the design matrix
    % 
    % s : struct           : data
    % m : struct           : model
    % x : cell of matrices : design

    %% function
    
    % default model
    m = struct_default(m,glm_model());
    if isempty(m.model), m.model = eye(length(m.regressor)); end
    
    % subject stuff
    x_subject = s.(m.subject);
    [u_subject,n_subject] = numbers(x_subject);
    
    % get regressor across subjects
    x_regressor = cellfun(@(r)s.(r),m.regressor,'UniformOutput',false);
    assertVector(x_regressor{:})
    x_regressor = cell_mat2vec(x_regressor);
    x_regressor = cat(2,x_regressor{:});

    % create design matrices
    x = cell(n_subject,1);
    for i_subject = 1:n_subject
        ii_subject   = (x_subject == u_subject(i_subject));
        x{i_subject} = x_regressor(ii_subject,:);
        if m.zscore, x{i_subject} = nan2zero(mat_zscore(x{i_subject},1)); end
        x{i_subject} = x2fx(x{i_subject},m.model);
    end
end
