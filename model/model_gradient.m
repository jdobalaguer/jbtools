
function model = model_gradient(model)
    %% model = model_gradient(model)
    % find a local minima through gradient descent
    
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
    
    % origin
    x0 = nan(n_pars,1);
    for i_pars = 1:n_pars
        x0(i_pars) = model.grad.origin.(u_pars{i_pars});
    end
    
    % apply gradient descent
    model.grad.result = cell(n_subject,n_index);
    jb_parallel_progress(n_subject * n_index);
    for i_subject = 1:n_subject
        for i_index = 1:n_index
            
            % indices
            ii_subject = (model.grad.subject == u_subject(i_subject));
            ii_index   = (model.grad.index{i_index});
            ii = (ii_subject & ii_index);
            
            % data
            data = struct_filter(model.grad.data,ii);
            
            % global variables
            glob_pars  = u_pars;
            glob_simu  = model.grad.simu;
            glob_cost  = model.grad.cost;
            
            % fminsearch
            result = struct();
            [result.u_min,result.v_min,exitflag] = fminsearch(@cost_function,x0,model.grad.option);
            assert(exitflag > 0,'model_gradient: error. limit iteration reached (%d,%d) \n',u_subject(i_subject),i_index);
            model.grad.result{i_subject,i_index} = result;
            
            % progress
            jb_parallel_progress();
        end
    end
    jb_parallel_progress(0);
    
    %% auxiliar
    function cost = cost_function(x)
        pars = [glob_pars';num2cell(x)'];
        pars = struct(pars{:});
        simu = glob_simu(data,pars);
        cost = glob_cost(data,simu);
    end 
end

