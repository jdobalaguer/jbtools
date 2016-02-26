
function model = model_bayes(model)
    %% model = MODEL_BAYES(model)
    % calculate maximum a posteriori (MAP) predictions of the model
    % following bayesian rule
    % see also: model_simulation
    
    %% notes
    % requires running @model_simulation
    % requires running @model_cost
    
    %% function
    
    % assert
    assert(struct_isfield(model,'simu.result'),      'model_bayes: error. you need to run @model_simulation');
    assert(struct_isfield(model,'cost.result.cost'), 'model_bayes: error. you need to run @model_cost');
    assert(~any(isnan(model.cost.result.cost(:))),   'model_bayes: error. some costs are nan');
    
    % numbers
    [u_subject,n_subject] = numbers(model.simu.subject);
    u_index = model.cost.index;
    n_index = length(u_index);
    u_pars  = fieldnames(model.simu.pars);
    n_pars  = length(u_pars);
    
    % joint probabilities (parameters)
    cost = model.cost.result.cost;
    if ischar(model.bayes.func)
        switch model.bayes.func
            case '1-probability',           model.bayes.func = @(x) 1-x;
            case 'negative log-likelihood', model.bayes.func = @(x) exp(nanmin(inf2nan(x(:)))-x);
        end
    end
    probability = nan(size(cost));
    for i_subject = 1:n_subject
        for i_index = 1:n_index
            tmp = model.bayes.func(cost(i_subject,i_index,:));
            probability(i_subject,i_index,:) = tmp ./ sum(tmp);
        end
    end
    assert(all(probability(:) >= 0), 'model_bayes: error. probabilities need >= 0.');
    assert(all(probability(:) <= 1), 'model_bayes: error. probabilities need <= 1.');
    model.bayes.result.probability = probability;
    clear tmp probability;
    
    % marginal probabilities (parameters)
    pars = struct2cell(model.simu.pars);
    [pars{1:n_pars}] = ndgrid(pars{:});
    model.bayes.result.marginal = struct();
    for i_pars = 1:n_pars
        marginal = nan(n_subject,n_index);
        for i_subject = 1:n_subject
            for i_index = 1:n_index
                 marginal(i_subject,i_index) = sum(pars{i_pars}(:) .* squeeze(model.bayes.result.probability(i_subject,i_index,:)));
            end
        end
        model.bayes.result.marginal.(u_pars{i_pars}) = marginal;
    end
    
    % predicted results
    model.bayes.result.reconstruction = struct_filter(model.simu.result.simulation(1),1);
    model.bayes.result.reconstruction = repmat(model.bayes.result.reconstruction,[n_index,1]);
    u_field = fieldnames(model.bayes.result.reconstruction);
    n_field = length(u_field);
    for i_index = 1:n_index
        reconstruction = struct_func(@(x)repmat(x,[length(u_index{i_index}),1]),...
                                     model.bayes.result.reconstruction(i_index,1));
        reconstruction = struct_func(@(v)nan(size(v)),reconstruction); % here we assume we work with numbers (no cells, strings or structs)
        for i_subject = 1:n_subject
            ii_subject = (model.simu.subject == u_subject(i_subject));
            ii_index   = model.simu.index{model.cost.simu{i_index}};
            ii = (ii_subject & ii_index);
            
            % obtain simulations and probabilities
            u_simulation  = num2cell(squeeze(model.simu.result.simulation(i_subject,model.cost.simu{i_index},:)));
            u_probability = squeeze(model.bayes.result.probability(i_subject,i_index,:));
            
            % weighted average
            n_dims = max(cell2mat(struct2cell(struct_func(@ndims,model.simu.result.simulation))));
            simulation = struct_concat(n_dims+1, u_simulation{:});
            for i_field = 1:n_field
                field = u_field{i_field};
                probability = reshape(u_probability,[ones(1,n_dims),numel(u_probability)]);
                probability = repmat(probability,mat_size(simulation.(field),1:n_dims));
                simulation.(field) = sum(simulation.(field) .* probability,n_dims+1);
            end
           
            % reconstruction
            reconstruction = struct_set(reconstruction,simulation,ii);
        end
        model.bayes.result.reconstruction(i_index) = reconstruction;
    end
    
    
    % cost of the bayesian prediction
    
end
