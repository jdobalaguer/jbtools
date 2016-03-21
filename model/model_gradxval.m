
function model = model_gradxval(model)
    %% model = MODEL_GRADXVAL(model)
    % apply gradient descent on each point of a grid
    % (the result is the best of them)
    % and si applied with cross-validation to test generalisation
    % this can work in parallel: use @mme_open
    % to list main functions, try
    %   >> help model;
    
    %% output
    % model.gradxval.result.minima{i_index}[sub,xval,origin] = struct('u',{},'v',{})
    % model.gradxval.result.best{i_index}[sub,xval]          = struct('u',{},'v',{})
    % model.gradxval.result.training{i_index}[sub,xval]      = double
    % model.gradxval.result.evaluate{i_index}[sub,xval]      = double
    
    %% warnings
    %#ok<>

    %% function
    
    % assert
    
    % default
    if ~struct_isfield(model,'gradxval.index'),    model.gradxval.index  = {logical(model.grad.subject)}; end
    if ~struct_isfield(model,'gradxval.search'),   model.gradxval.search = struct(); end
    model.gradxval.search = struct_default(model.gradxval.search,struct('solver',{'fminsearch'},'options',{[]}));
    if ~struct_isfield(model,'gradxval.leave'),    model.gradxval.leave  = 1;  end
    
    % numbers
    u_pars = fieldnames(model.gradxval.origin);
    n_pars = length(u_pars);
    [u_subject,n_subject] = numbers(model.gradxval.subject);
    u_index  = model.gradxval.index;
    n_index  = length(u_index);
    
    % set up parameters
    model.gradxval.origin = struct_mat2vec(model.gradxval.origin);
    c_pars = cell(1,n_pars);
    for i_pars = 1:n_pars
        c_pars{i_pars} =  model.gradxval.origin.(u_pars{i_pars});
    end
    u_comb = vec_combination(c_pars{:});
    n_comb = size(u_comb,1);
    
    % initialise variables
    model.gradxval.result.minima   = cell(n_index,1);
    model.gradxval.result.best     = cell(n_index,1);
    model.gradxval.result.training = cell(n_index,1);
    model.gradxval.result.evaluate = cell(n_index,1);
    for i_index = 1:n_index

        % indices
        ii_index = model.gradxval.index{i_index};
        [u_block,n_block] = numbers(model.gradxval.block(ii_index));
        
        % datasets
        xval_training = combnk(u_block,n_block - model.gradxval.leave);
        if isvector(xval_training), xval_training = mat2vec(xval_training); end
        xval_training = mat2cell(xval_training,ones(size(xval_training,1),1));
        xval_evaluate = cellfun(@(t) u_block(~ismember(u_block,t)),xval_training,'UniformOutput',false);
        n_xval = numel(xval_training);

        % initialise variables
        model.gradxval.result.minima{i_index}   = repmat(struct('u',{[]},'v',{[]}),[n_subject,n_xval,n_comb]);
        model.gradxval.result.best{i_index}     = repmat(struct('u',{[]},'v',{[]},'o',{[]}),[n_subject,n_xval]);
        model.gradxval.result.training{i_index} = nan([n_subject,n_xval],'single');
        model.gradxval.result.evaluate{i_index} = nan([n_subject,n_xval],'single');
        
        % wait
        fw = func_wait(n_subject * n_xval * n_comb);
        
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
                assert(any(ii_index & ii_subject & ii_training),'model_gradxval: error. index (%d) doesnt cover training',  i_index);
                assert(any(ii_index & ii_subject & ii_evaluate),'model_gradxval: error. index (%d) doesnt cover evaluation',i_index);
                
                % datasets
                training = struct_filter(model.gradxval.data,ii_index & ii_subject & ii_training);
                evaluate = struct_filter(model.gradxval.data,ii_index & ii_subject & ii_evaluate);

                % apply gradient-descent
                % (from @model_gradient)
                parfor_result = repmat(struct('u_min',[],'v_min',[]),[n_comb,1]);
                parfor_simu_pars   = u_pars;
                parfor_simu_func   = model.gradxval.simu;
                parfor_cost_pars   = model.gradxval.costpars;
                parfor_cost_func   = model.gradxval.costfunc;
                parfor_data        = training;
                parfor_problem     = model.gradxval.search;

                parfor (i_comb = 1:n_comb, mme_size())
                    % comb
                    parfor_x0 = u_comb(i_comb,:)';

                    % gradiend
                    parfor_result(i_comb) = model_gradient_parfor(parfor_problem,parfor_x0,parfor_simu_pars,parfor_simu_func,parfor_cost_pars,parfor_cost_func,parfor_data);

                    % progress
                    func_wait([],fw);
                end
                
                % save minimas
                model.gradxval.result.minima{i_index}(i_subject,i_xval,:) = struct('u',{parfor_result.u_min},'v',{parfor_result.v_min});
                
                % save best
                parfor_v        = [parfor_result.v_min];
                [v_min,ii_min]  = min(parfor_v);
                model.gradxval.result.best{i_index}(i_subject,i_xval).u = parfor_result(ii_min).u_min; % best fit
                model.gradxval.result.best{i_index}(i_subject,i_xval).v = v_min; % best cost
                model.gradxval.result.best{i_index}(i_subject,i_xval).o = u_comb(ii_min,:)'; % origin
                
                % save training/evaluation cost
                best_simu_pars = pair2struct([parfor_simu_pars,num2cell(parfor_result(ii_min).u_min)]');
                best_simu_training = parfor_simu_func(training,best_simu_pars);
                best_simu_evaluate = parfor_simu_func(evaluate,best_simu_pars);
                best_cost_training = parfor_cost_func(training,best_simu_training,parfor_cost_pars);
                best_cost_evaluate = parfor_cost_func(evaluate,best_simu_evaluate,parfor_cost_pars);
                model.gradxval.result.training{i_index}(i_subject,i_xval) = best_cost_training;
                model.gradxval.result.evaluate{i_index}(i_subject,i_xval) = best_cost_evaluate;
            end
        end
    end
end
