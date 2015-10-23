
function model = model_cost(model)
    %% model = MODEL_COST(model)
    % calculate the cost of each parameterisation
    % this can work in parallel: use @mme_open
    % see also: model_simulation
    %           model_minimum
    %           model_gradient
    
    %% warnings
    %#ok<*ASGLU,*PFBNS>
    
    %% function
    
    % assert
    assert(struct_isfield(model,'simu.result.simulation'),      'model_cost: error. no "model.simu.result.simulation" field');
    
    % numbers
    s_comb = size(model.simu.result.simulation); s_comb(1:2) = [];
    n_comb = prod(s_comb);
    
    % subject
    [u_subject,n_subject] = numbers(model.simu.subject);
    
    % index
    if ~struct_isfield(model,'cost.index'), model.cost.index = model.simu.index; end
    assert(length(model.cost.index) == length(model.cost.simu), 'model_cost: error. "index" and "simu" have different length');
    
    u_index = model.cost.index;
    n_index = length(u_index);
    
    % result
    model.cost.result      = struct();
    model.cost.result.cost = nan([n_subject,n_index,s_comb]);
    
    % cost
    fw = func_wait(n_subject * n_index * n_comb);
    for i_subject = 1:n_subject
        
        % subject
        subject = u_subject(i_subject);
        ii_subject = (model.simu.subject == subject);
        for i_index = 1:n_index
            
            % index
            i_simu  = model.cost.simu{i_index};
            ii_simu = model.simu.index{i_simu};
            ii_cost = u_index{i_index};
            
            assert(all(ii_simu(ii_cost & ii_subject)),'model_cost: error. simu(%d) doesnt cover index(%d)',model.cost.simu{i_index},i_index);
            
            % data
            data = struct_filter(model.simu.data,ii_subject & ii_cost);
            
            % pars
            pars = model.cost.pars;
            
            % parfor
            parfor_simu   = model.simu.result.simulation(i_subject,i_simu,:);
            parfor_ii     = logical(ii_cost(ii_subject & ii_simu));
            parfor_result = model.cost.result.cost(i_subject,i_index,:);
            parfor_func   = model.cost.func;
            parfor (i_comb = 1:n_comb, mme_size())
                
                % simu
                simu = struct_filter(parfor_simu(i_comb),parfor_ii);
                
                % run
                parfor_result(i_comb) = parfor_func(data,simu,pars);
                
                % progress
                func_wait([],fw);
            end
            model.cost.result.cost(i_subject,i_index,:) = parfor_result;
        end
    end
    func_wait(0,fw);
    
end
