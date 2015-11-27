
function model = model_reconstruction(model)
    %% model = MODEL_RECONSTRUCTION(model)
    % reconstruct the simulation based on the original indices
    % (i.e. one vector for all subjects)
    
    %% warnings
    
    %% assert
    assert(struct_isfield(model,'simu.result.simulation'),'model_reconstruction: error. no "model.simu.result.simulation" field');
    
    %% function
    
    % numbers
    s_comb = size(model.simu.result.simulation); s_comb(1:2) = [];
    n_comb = prod(s_comb);
    
    % subject
    [u_subject,n_subject] = numbers(model.simu.subject);
    
    % index
    u_index = model.simu.index;
    n_index = length(u_index);
    
    % result
    model.simu.result.reconstruction = struct_filter(model.simu.result.simulation(1),1);
    model.simu.result.reconstruction = repmat(model.simu.result.reconstruction,[n_index,s_comb]);
    for i_index = 1:n_index
        for i_comb = 1:n_comb
            reconstruction = struct_func(@(x)repmat(x,[length(u_index{i_index}),1]),...
                                         model.simu.result.reconstruction(i_index,i_comb));
            for i_subject = 1:n_subject
                ii_index   = u_index{i_index};
                ii_subject = (model.simu.subject == u_subject(i_subject));
                ii = (ii_index & ii_subject);
                simulation = model.simu.result.simulation(i_subject,i_index,i_comb);
                reconstruction = struct_set(reconstruction,simulation,ii);
            end
            model.simu.result.reconstruction(i_index,i_comb) = reconstruction;
        end
    end
    
end