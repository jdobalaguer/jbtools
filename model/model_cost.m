
function model = model_cost(model)
    %% model = model_cost(model)
    
    %% warnings
    %#ok<*ASGLU>
    
    %% assert
    assert(isfield(model.simu,'result'), 'model_cost: error. no "model.simu.result" field');
    
    %% function
    % numbers
    n_comb = numel(model.simu.result);
    
    % subject
    [u_subject,n_subject] = numbers(model.simu.subject);
    
    % index
    u_index = model.cost.index;
    n_index = length(u_index);
    
    % result
    model.cost.result      = struct();
    model.cost.result.cost = nan([n_subject,n_index,size(model.simu.result)]);
    
    % cost
    jb_parallel_progress(n_subject * n_index);
    for i_subject = 1:n_subject
        
        % subject
        subject = u_subject(i_subject);
        ii_subject = (model.simu.subject == subject);
        for i_index = 1:n_index
            
            % index
            ii_index   = u_index{i_index};
            ii         = (ii_subject & ii_index);
            for i_comb = 1:n_comb
                
                % data
                data = struct_filter(model.simu.data,ii);
                
                % simu
                simu = struct_filter(model.simu.result(i_comb),ii);
                
                % pars
                pars = model.cost.pars;
                
                % run
                model.cost.result.cost(i_subject,i_index,i_comb) = model.cost.func(data,simu,pars);
            end
            jb_parallel_progress();
        end
    end
    jb_parallel_progress(0);
    
end
