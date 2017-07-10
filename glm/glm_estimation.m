
function a = glm_estimation(x,y,o)
    %% a = GLM_ESTIMATION(x,y,o)
    % Estimate the coefficients of the regression
    % 
    % x : cell of matrices  : design
    % y : cell of vectors   : target
    % o : struct            : options
    % a : vector of structs : estimation

    %% function
    
    % assert
    assertLength(x,y);
    
    % default options
    func_default('o',struct());
    o = struct_default(o,glm_options());
    o_pair = struct2pair(struct_rm(o,'dist','zscore'));
    
    % numbers
    n_subject = numel(x);
    
    % estimation
    a = cell(n_subject,1);
    for i_subject = 1:n_subject
        a{i_subject} = cell(size(y{i_subject},2),1);
        for i_y = 1:size(y{i_subject},2)
            [~,~,a{i_subject}{i_y}] = glmfit(x{i_subject},y{i_subject}(:,i_y),o.dist,o_pair{:});
        end
        a{i_subject} = struct_concat(3,a{i_subject}{:});
    end
    a = cat(1,a{:});
end
