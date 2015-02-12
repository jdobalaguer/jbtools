
function model = model_reconstruction(model)
    %% model = MODEL_RECONSTRUCTION(model)
    % reconstruct the simulation based on the original indices
    % (i.e. one vector for all subjects)
    
    %% warnings
    
    %% assert
    assert(isfieldp(model,'simu.result.simulation'),'model_reconstruction: error. no "model.simu.result.simulation" field');
    
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
    model.simu.result.reconstruction = struct_filter(model.simu.result.simulation(1));
    model.simu.result.reconstruction = repmat(model.simu.result.simulation(1),[n_index,n_comb]);
    for i_index = 1:n_index
        for i_comb = 1:n_comb
            reconstruction = 
            
            
            
        end
    end
    
end