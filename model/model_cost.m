
function model = model_cost(model)
    %% model = model_cost(model)
    % calculate the cost of each fitting
    % see also: model_simulation
    
    %% warnings
    %#ok<*ASGLU>
    
    %% assert
    assert(isfield(model.simu,'result'), 'model_cost: error. no "model.simu.result" field');
    assert(length(model.cost.index) == length(model.cost.simu), 'model_cost: error. "index" and "simu" have different length');
    
    %% function
    % numbers
    s_comb = size(model.simu.result); s_comb(1:2) = [];
    n_comb = prod(s_comb);
    
    % subject
    [u_subject,n_subject] = numbers(model.simu.subject);
    
    % index
    u_index = model.cost.index;
    n_index = length(u_index);
    
    % result
    model.cost.result      = struct();
    model.cost.result.cost = nan([n_subject,n_index,s_comb]);
    
    % cost
    jb_parallel_progress(n_subject * n_index * n_comb);
    for i_subject = 1:n_subject
        
        % subject
        subject = u_subject(i_subject);
        ii_subject = (model.simu.subject == subject);
        for i_index = 1:n_index
            
            % index
            i_simu  = model.cost.simu{i_index};
            ii_simu = model.simu.index{i_simu};
            ii_cost = u_index{i_index};
            
            assert(all(ii_simu(ii_cost & ii_subject)),'model_cost: error. some simu(%d) doesnt cover index(%d)',model.cost.simu{i_index},i_index);
            
            parfor i_comb = 1:n_comb
                
                % data
                data = struct_filter(model.simu.data,ii_subject & ii_cost);
                
                % simu
                simu = struct_filter(model.simu.result(i_subject,i_simu,i_comb),ii_cost(ii_subject & ii_simu));
                
                % pars
                pars = model.cost.pars;
                
                % run
                model.cost.result.cost(i_subject,i_index,i_comb) = model.cost.func(data,simu,pars);
                
                % progress
                jb_parallel_progress();
            end
        end
    end
    jb_parallel_progress(0);
    
end
