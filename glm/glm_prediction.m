
function z = glm_prediction(a,x,o)
    %% z = GLM_PREDICTION(a,x,o)
    % Build the prediction [z] from the regressors [x] and the coefficients [b]
    % 
    % a : vector of structs : estimation
    % x : cell of matrices  : design
    % o : struct            : options
    % z : cell of vectors   : predictions
    
    %% function
    
    % default options
    func_default('o',[]);
    o = struct_default(o,glm_options());
    o_pair = struct2pair(struct_rm(o,{'dist','link'}));
    
    % assert
    assertLength(a,x)
    
    % numbers
    n_subject = numel(x);
    
    % prediction
    z = cell(n_subject,1);
    b = mat2vec({a.beta});
    for i_subject = 1:n_subject
        z{i_subject} = glmval(b{i_subject},x{i_subject},o.link,o_pair{:});
    end
end
