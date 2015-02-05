
function model = model_gradient(model)
    %% model = model_gradient(model)
    % apply gradient descent on each point of a grid
    % the result is the best of them
    
    %% warnings
    %#ok<>

    %% function
    
    % default
    if ~isfield(model.grad,'index'),    model.grad.index  = {logical(model.grad.subject)}; end
    if ~isfield(model.grad,'option'),   model.grad.option = []; end
    
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
    u_comb = jb_allcomb(c_pars{:});
    n_comb = size(u_comb,1);

    % apply gradient descent
    model.grad.result = cell(n_subject,n_index);
    jb_parallel_progress(n_subject * n_index * n_comb);
    for i_subject = 1:n_subject
        for i_index = 1:n_index
            
            % indices
            ii_subject = (model.grad.subject == u_subject(i_subject));
            ii_index   = (model.grad.index{i_index});
            ii = (ii_subject & ii_index);
            
            % data
            data = struct_filter(model.grad.data,ii);
            
            % problem
            problem = struct();
            problem.options   = model.grad.option;
            problem.solver    = 'fminsearch';
            
            % parfor
            parfor_result = repmat(struct('u_min',[],'v_min',[]),[n_comb,1]);
            parfor_pars   = u_pars;
            parfor_simu   = model.simu.func;
            parfor_cost   = model.cost.func;
            parfor_data   = data;
            
            parfor i_comb = 1:n_comb
                % comb
                parfor_x0 = u_comb(i_comb,:)';
                
                % gradiend
                parfor_result(i_comb) = model_gradient_parfor(problem,parfor_x0,parfor_pars,parfor_simu,parfor_cost,parfor_data);
                
                % progress
                jb_parallel_progress();
            end
            
            % save minima
            v_comb = [parfor_result(:).v_min];
            f_comb = find(v_comb == nanmin(v_comb),1,'first');
            model.grad.result{i_subject,i_index} = parfor_result(f_comb);
        end
    end
    jb_parallel_progress(0);
    
end

