
function model = model_simulation(model)
    %% model = model_simulation(model)
    % run a (grid of) simulation(s) of a model
    % see also: model_cost
    %           model_gradient
    
    %% warnings
    %#ok<*PFBNS>

    %% function
    
    % set up parameters
    model.simu.pars = struct_mat2vec(model.simu.pars);
    u_pars = fieldnames(model.simu.pars);
    n_pars = length(u_pars);
    c_pars = cell(1,n_pars);
    for i_pars = 1:n_pars
        c_pars{i_pars} =  model.simu.pars.(u_pars{i_pars});
    end
    u_comb = jb_allcomb(c_pars{:});
    n_comb = size(u_comb,1);
    s_comb = cellfun(@numel,c_pars);

    % subject
    [u_subject,n_subject] = numbers(model.simu.subject);
    
    % index
    if ~isfield(model.simu,'index'), model.simu.index = {ones(size(model.simu.subject))}; end
    u_index = model.simu.index;
    n_index = length(u_index);
    
    % initialize result
    data = struct_filter(model.simu.data,[]);
    pars = struct_filter(model.simu.pars,1);
    model.simu.result = model.simu.func(data,pars);
    u_result = fieldnames(model.simu.result);
    n_result = length(u_result);
    for i_result = 1:n_result
        model.simu.result.(u_result{i_result}) = [];
    end
    model.simu.result = repmat(model.simu.result,[n_subject,n_index,s_comb]);
    
    % simulations
    jb_parallel_progress(n_subject * n_index * n_comb);
    for i_subject = 1:n_subject

        % subject
        subject = u_subject(i_subject);
        ii_subject = (model.simu.subject == subject);
        for i_index = 1:n_index
                
            % index
            ii_index   = u_index{i_index};
            ii = (ii_subject & ii_index);
            
            % data
            data = struct_filter(model.simu.data,ii);
            
            % parfor
            parfor_result = model.simu.result(i_subject,i_index,:);
            parfor_func   = model.simu.func;
            parfor i_comb = 1:n_comb
                
                % comb
                pars = [u_pars';num2cell(u_comb(i_comb,:))];
                pars = struct(pars{:});
                
                % run
                parfor_result(i_comb) = parfor_func(data,pars);
                
                % progress
                jb_parallel_progress();
            end
            model.simu.result(i_subject,i_index,:) = parfor_result;
        end
    end
    jb_parallel_progress(0);

end