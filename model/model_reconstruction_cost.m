
function model = model_reconstruction_cost(model)
    %% model = MODEL_RECONSTRUCTION_COST(model)
    % reconstruct the simulation based on the original indices
    % (i.e. one vector for all subjects)
    % using best parameters for each subject
    
    %% assert
    assert(struct_isfield(model,'simu.subject'),           'model_reconstruction_min: error. no "model.simu.subject" field');
    assert(struct_isfield(model,'simu.result.simulation'), 'model_reconstruction_min: error. no "model.simu.result.simulation" field');
    assert(struct_isfield(model,'cost.result.min_subject'),'model_reconstruction_min: error. no "model.result.min_subject" field');
    
    %% function
    
    % numbers
    [u_subject,n_subject] = numbers(model.simu.subject);
    u_index = model.cost.index;
    n_index = length(u_index);
    s_comb = size(model.simu.result.simulation); s_comb(1:2) = [];
    
    
    % if no parameters (similar to @model_reconstruction_simu)
    if isempty(s_comb)
        model = model_reconstruction_simu(model);
        model.cost.result.reconstruction = model.simu.result.reconstruction;
        return;
    end
    
    % result
    model.cost.result.reconstruction = struct_filter(model.simu.result.simulation(1),1);
    model.cost.result.reconstruction = repmat(model.cost.result.reconstruction,[n_index,1]);
    for i_index = 1:n_index
        reconstruction = struct_func(@(x)repmat(x,[length(u_index{i_index}),1]),...
                                     model.cost.result.reconstruction(i_index,1));
        reconstruction = struct_func(@(v)nan(size(v)),reconstruction); % here we assume we work with numbers (no cells, strings or structs)
        for i_subject = 1:n_subject
            ii_subject = (model.simu.subject == u_subject(i_subject));
            ii_index   = model.simu.index{model.cost.simu{i_index}};
            ii = (ii_subject & ii_index);
            i_comb = num2cell(model.cost.result.min_subject(i_subject).i_min(1,:)); % if more than one minimum, take the first one
            if isscalar(s_comb),    i_comb = i_comb{1};
            else                    i_comb = sub2ind(s_comb,i_comb{:});
            end
            simulation = model.simu.result.simulation(i_subject,model.cost.simu{i_index},i_comb);
            reconstruction = struct_set(reconstruction,simulation,ii);
        end
        model.cost.result.reconstruction(i_index) = reconstruction;
    end
end
