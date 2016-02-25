
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
    assert(struct_isfield(model,'simu.result'),'model_bayes: error. you need to run @model_simulation');
    assert(struct_isfield(model,'simu.result'),'model_bayes: error. you need to run @model_cost');
    
    % subject
    [u_subject,n_subject] = numbers(model.simu.subject);
    
    % index
    u_index = model.cost.index;
    n_index = length(u_index);
    
    % transform cost into probabilities
    cost = model.cost.result.cost;
    if ischar(model.bayes.func)
        switch model.bayes.func
            case '1-probability',           model.bayes.func = @(x) 1-x;
            case 'negative log-likelihood', model.bayes.func = @(x) exp(-x);
        end
    end
    cost = model.bayes.func(cost);
    cost = cost ./ sum(cost(:));
    
    % make predictions
    % TODO
end
