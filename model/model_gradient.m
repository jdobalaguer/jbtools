
function model = model_gradient(model)
    %% model = MODEL_GRADIENT(model)
    % apply gradient descent on each point of a grid
    % the result is the best of them
    % this can work in parallel: use @mme_open
    % to list main functions, try
    %   >> help model;
    
    %% notes
    % results @MODEL_GRADIENT
    % model.gradxval.result.best{index}[sub] = struct('u',{},'v',{})

    %% function
    
    % default
    if ~struct_isfield(model,'grad.glob'),     model.grad.glob = struct(); end
    if ~struct_isfield(model,'grad.index'),    model.grad.index  = {logical(model.grad.subject)}; end
    if ~struct_isfield(model,'grad.search'),   model.grad.search = struct(); end
    model.grad.search = struct_default(model.grad.search,struct('solver',{'fminsearch'},'options',{[]}));
    
    % numbers
    u_pars = fieldnames(model.grad.origin);
    n_pars = length(u_pars);
    [u_subject,n_subject] = numbers(model.grad.subject);
    n_index = length(model.grad.index);
    
    % set up parameters
    model.grad.origin = struct_mat2vec(model.grad.origin);
    c_pars = cell(1,n_pars);
    for i_pars = 1:n_pars
        c_pars{i_pars} =  model.grad.origin.(u_pars{i_pars});
    end
    u_comb = vec_combination(c_pars{:});
    n_comb = size(u_comb,1);
    s_comb = cellfun(@numel,c_pars);

    % apply gradient descent
    model.grad.result.best = cell([n_index,1]);
    fw = func_wait(n_subject * n_index * n_comb);
    for i_index = 1:n_index
        
        % initialise variables
        model.grad.result.minima{i_index} = repmat(struct('u',{[]},'v',{[]}),[n_subject,s_comb]);
        model.grad.result.best{i_index}   = repmat(struct('u_min',[],'v_min',[]),[n_subject,1]);
        for i_subject = 1:n_subject
            
            % indices
            ii_subject = (model.grad.subject == u_subject(i_subject));
            ii_index   = (model.grad.index{i_index});
            ii = (ii_subject & ii_index);
            
            % data
            data = struct_filter(model.grad.data,ii);
            
            % parfor
            parfor_result      = repmat(struct('u_min',[],'v_min',[]),[n_comb,1]);
            parfor_simu_glob   = model.grad.glob;
            parfor_simu_pars   = u_pars;
            parfor_simu_func   = model.grad.simu;
            parfor_cost_pars   = model.grad.costpars;
            parfor_cost_func   = model.grad.costfunc;
            parfor_data        = data;
            parfor_problem     = model.grad.search;
            
            parfor (i_comb = 1:n_comb, mme_size())
                % comb
                parfor_x0 = u_comb(i_comb,:)';
                
                % gradiend
                parfor_result(i_comb) = model_gradient_parfor(parfor_problem,parfor_x0,parfor_simu_glob,parfor_simu_pars,parfor_simu_func,parfor_cost_pars,parfor_cost_func,parfor_data);
                
                % progress
                func_wait([],fw);
            end
            
            % save minima
            model.grad.result.minima{i_index}(i_subject,:) = struct('u',{parfor_result.u_min},'v',{parfor_result.v_min});
            
            % save best
            v_comb = [parfor_result(:).v_min];
            f_comb = find(v_comb == nanmin(v_comb),1,'first');
            model.grad.result.best{i_index}(i_subject) = parfor_result(f_comb);
        end
    end
    func_wait(0,fw);
    
end

