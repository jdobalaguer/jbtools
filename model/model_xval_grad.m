
function model = model_xval_grad(model)
    %% model = MODEL_XVAL_GRAD(model)
    % calculate the cross-validated fitting
    % this can work in parallel: use @mme_open
    % see also: model_gradient
    
    %% function
    
    % default
    func_default('model.gradxval.leave',  1);
    func_default('model.gradxval.index',  {logical(model.gradxval.subject)});
    func_default('model.gradxval.glob',   struct());
    func_default('model.gradxval.search', struct());
    model.gradxval.search = struct_default(model.gradxval.search,struct('solver',{'fminsearch'},'options',{[]}));
    
    % numbers
    u_pars = fieldnames(model.gradxval.origin);
    n_pars = length(u_pars);
    [u_subject,n_subject] = numbers(model.gradxval.subject);
    n_index = length(model.gradxval.index);
    
    % set up parameters
    model.gradxval.origin = struct_mat2vec(model.gradxval.origin);
    c_pars = cell(1,n_pars);
    for i_pars = 1:n_pars
        c_pars{i_pars} =  model.gradxval.origin.(u_pars{i_pars});
    end
    u_comb = vec_combination(c_pars{:});
    n_comb = size(u_comb,1);
    s_comb = cellfun(@numel,c_pars);

    % initialise variables
    model.gradxval.result = struct('training',cell(n_index,1),'evaluate',cell(n_index,1));
    
    for i_index = 1:n_index

        % indices
        ii_index    = model.gradxval.index{i_index};
        [u_block,n_block] = numbers(model.gradxval.block(ii_index));
        
        % datasets
        xval_training = combnk(u_block,n_block - model.gradxval.leave);
        if isvector(xval_training), xval_training = mat2vec(xval_training); end
        xval_training = mat2cell(xval_training,ones(size(xval_training,1),1));
        xval_evaluate = cellfun(@(t) u_block(~ismember(u_block,t)),xval_training,'UniformOutput',false);
        n_xval = numel(xval_training);

        % initialise variables
        model.gradxval.result(i_index).training.cost = repmat(struct('u_min',{[]},'v_min',{[]}),[n_subject,n_xval,s_comb]);
        model.gradxval.result(i_index).training.min  = repmat(struct('u_min',{[]},'v_min',{[]}),[n_subject,n_xval]);
        model.gradxval.result(i_index).evaluate.cost = nan([n_subject,n_xval,s_comb],'single');
        model.gradxval.result(i_index).evaluate.min  = nan([n_subject,n_xval],'single');
        
        % wait
        fw = func_wait(n_subject * n_xval);
        
        % cross-validation
        for i_subject = 1:n_subject
            for i_xval = 1:n_xval
                
                % subject
                subject = u_subject(i_subject);
                ii_subject = (model.gradxval.subject == subject);

                % cross-validation indices
                ii_index    = model.gradxval.index{i_index};
                ii_training = ismember(model.gradxval.block,xval_training{i_xval});
                ii_evaluate = ismember(model.gradxval.block,xval_evaluate{i_xval});
                func_assert(any(ii_index & ii_subject & ii_training),'error. index (%d) doesnt cover training',  i_index);
                func_assert(any(ii_index & ii_subject & ii_evaluate),'error. index (%d) doesnt cover evaluation',i_index);

                % training parameters/cost (based on @model_gradient)
                parfor_result      = model.gradxval.result(i_index).training.cost(i_subject,i_xval,:);
                parfor_simu_glob   = model.gradxval.glob;
                parfor_simu_pars   = u_pars;
                parfor_simu_func   = model.gradxval.simu;
                parfor_cost_pars   = model.gradxval.costpars;
                parfor_cost_func   = model.gradxval.costfunc;
                parfor_data        = struct_filter(model.gradxval.data,ii_index & ii_subject & ii_training);
                parfor_problem     = model.gradxval.search;
                parfor (i_comb = 1:n_comb, mme_size())
                    parfor_x0 = u_comb(i_comb,:)';
                    parfor_result(i_comb) = model_gradient_parfor(parfor_problem,parfor_x0,parfor_simu_glob,parfor_simu_pars,parfor_simu_func,parfor_cost_pars,parfor_cost_func,parfor_data);
                end
                model.gradxval.result(i_index).training.cost(i_subject,i_xval,:) = parfor_result;
                
                % training min (based on @model_gradient)
                v_comb = [parfor_result(:).v_min];
                f_comb = find(v_comb == nanmin(v_comb),1,'first');
                model.gradxval.result(i_index).training.min(i_subject,i_xval) = parfor_result(f_comb);

                % evaluate cost
                parfor_data        = struct_filter(model.gradxval.data,ii_index & ii_subject & ii_evaluate);
                parfor_result      = model.gradxval.result(i_index).evaluate.cost(i_subject,i_xval,:);
                parfor (i_comb = 1:n_comb, mme_size())
                    pars = cell2struct(num2cell(u_comb(i_comb,:)'),parfor_simu_pars);
                    parfor_result(i_comb) = parfor_cost_func(parfor_data,...
                                                             parfor_simu_func(parfor_data,...
                                                                              pars,...
                                                                              parfor_simu_glob),...
                                                             parfor_cost_pars);
                end
                model.gradxval.result(i_index).evaluate.cost(i_subject,i_xval,:) = parfor_result;
                
                % evaluate min (based on @model_gradient)
                pars = cell2struct(num2cell(model.gradxval.result(i_index).training.min(i_subject,i_xval).u_min),parfor_simu_pars);
                model.gradxval.result(i_index).evaluate.min(i_subject,i_xval) = parfor_cost_func(parfor_data,...
                                                                                                 parfor_simu_func(parfor_data,...
                                                                                                                  pars,...
                                                                                                                  parfor_simu_glob),...
                                                                                                 parfor_cost_pars);
                
                % wait
                func_wait([],fw);
            end
        end
        func_wait(0,fw);
    end
end
