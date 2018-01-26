
function model = model_bayes(model)
    %% model = MODEL_BAYES(model)
    % calculate a combined prediction with the different 
    % parameters of the model, following bayes' rule
    % see also: model_simulation
    
    %% notes
    % requires running @model_simulation
    % requires running @model_cost
    
    %% TODO
    % 1) take in a prior, default flat
    % 2) marginal probabilities
    % 3) mean a posteriori
    % 4) functions for bayesian inference?
    
    %% function
    
    % assert
    assert(struct_isfield(model,'simu.result'),                 'model_bayes: error. you need to run @model_simulation');
    assert(struct_isfield(model,'simu.result.reconstruction'),  'model_bayes: error. you need to run @model_reconstruction_simu');
    assert(struct_isfield(model,'cost.result.cost'),            'model_bayes: error. you need to run @model_cost');
    assert(~any(isnan(model.cost.result.cost(:))),              'model_bayes: error. some costs are nan');
    
    % numbers
    [u_subject,n_subject] = numbers(model.simu.subject);
    u_index = model.cost.index;
    n_index = length(u_index);
    u_pars  = fieldnames(model.simu.pars);
    n_pars  = length(u_pars);
    
    % values
    t_pars = struct2cell(model.simu.pars);  % per parameter values
    k_pars = cellfun(@numel,t_pars);        % per parameter number
    [x_pars{1:n_pars}] = ndgrid(t_pars{:}); % parameter grid
    
    % default [model.bayes.func]
    if ischar(model.bayes.func)
        switch model.bayes.func
            case '1-probability',           model.bayes.func = @(x) 1-x;
            case 'negative log-likelihood', model.bayes.func = @(x) exp(nanmin(inf2nan(x(:)))-x);
        end
    end
    
    % default [model.bayes.prior]
    if ~struct_isfield(model,'bayes.prior')
        model.bayes.prior = nan(size(model.cost.result.cost));
        model.bayes.prior(:) = 1 ./ prod(mat_size(model.bayes.prior,2+(1:n_pars)));
    end
    assert(isequal(size(model.bayes.prior),size(model.cost.result.cost)),  'model_bayes: error. prior has wrong size');
    assert(all(model.bayes.prior(:) >= 0),                                 'model_bayes: error. prior is not a probability');
    assert(all(mat2vec(abs(sum(model.bayes.prior(:,:,:),3) - 1))< 1e-5),   'model_bayes: error. prior is not a probability');
    
    % joint posterior (parameters)
    cost = model.cost.result.cost;
    posterior = nan(size(cost));
    for i_subject = 1:n_subject
        for i_index = 1:n_index
            tmp = model.bayes.func(cost(i_subject,i_index,:));   % likelihood
            tmp = tmp .* model.bayes.prior(i_subject,i_index,:); % prior
            posterior(i_subject,i_index,:) = tmp ./ sum(tmp);
        end
    end
    assert(all(posterior(:) >= 0), 'model_bayes: error. probabilities need >= 0.');
    assert(all(posterior(:) <= 1), 'model_bayes: error. probabilities need <= 1.');
    model.bayes.result.posterior = posterior;
    clear tmp posterior;
    
    % posterior marginal PDF
    model.bayes.result.marginal.pdf = struct();
    for i_pars = 1:n_pars
        marginal_pdf = nan(n_subject,n_index,k_pars(i_pars));
        for i_subject = 1:n_subject
            for i_index = 1:n_index
                tmp_i = 2+(1:n_pars);
                tmp_i(tmp_i == (i_pars+2)) = [];
                tmp_i = [1:2,i_pars+2,tmp_i];
                tmp_p = permute(model.bayes.result.posterior,tmp_i);
                marginal_pdf(i_subject,i_index,:) = sum(tmp_p(i_subject,i_index,:,:),4);
            end
        end
        model.bayes.result.marginal.pdf.(u_pars{i_pars}) = marginal_pdf;
    end
    clear tmp_i tmp_p
    
    % posterior marginal mean
    model.bayes.result.marginal.mean = struct();
    for i_pars = 1:n_pars
        marginal_mean = nan(n_subject,n_index);
        for i_subject = 1:n_subject
            for i_index = 1:n_index
                 marginal_mean(i_subject,i_index) = sum(x_pars{i_pars}(:) .* squeeze(model.bayes.result.posterior(i_subject,i_index,:)));
            end
        end
        model.bayes.result.marginal.mean.(u_pars{i_pars}) = marginal_mean;
    end
    
    % mean combined prediction
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
            u_simulation = num2cell(squeeze(model.simu.result.simulation(i_subject,model.cost.simu{i_index},:)));
            u_posterior  = squeeze(model.bayes.result.posterior(i_subject,i_index,:));
            
            % weighted average
            n_dims = max(cell2mat(struct2cell(struct_func(@ndims,model.simu.result.simulation))));
            simulation = struct_concat(n_dims+1, u_simulation{:});
            for i_field = 1:n_field
                field = u_field{i_field};
                posterior = reshape(u_posterior,[ones(1,n_dims),numel(u_posterior)]);
                posterior = repmat(posterior,mat_size(simulation.(field),1:n_dims));
                simulation.(field) = sum(simulation.(field) .* posterior,n_dims+1);
            end
           
            % reconstruction
            reconstruction = struct_set(reconstruction,simulation,ii);
        end
        model.bayes.result.reconstruction(i_index) = reconstruction;
    end
    
    
    % cost of the bayesian prediction
    
end
