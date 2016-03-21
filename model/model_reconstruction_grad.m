
function model = model_reconstruction_grad(model)
    %% model = MODEL_RECONSTRUCTION_GRAD(model)
    % reconstruct the simulation based on the fitted parameters
    % (i.e. one vector for all subjects)
    % using best parameters for each subject
    
    %% assert
    assert(struct_isfield(model,'grad.subject'),    'model_reconstruction_grad: error. no "model.grad.subject" field');
    assert(struct_isfield(model,'grad.result.best'),'model_reconstruction_grad: error. no "model.grad.result.best" field');
    
    %% function
    
    % numbers
    [u_subject,n_subject] = numbers(model.grad.subject);
    u_index = model.grad.index;
    n_index = length(u_index);
    
    % initialise
    data = struct_filter(model.grad.data,[]);
    pars = struct_filter(model.grad.origin,[]);
    reconstruction = model.grad.simu(data,pars);
    reconstruction = struct_func(@add_row,reconstruction);
    reconstruction = struct_func(@(x) repmat(x,length(model.grad.subject),1),reconstruction);
    reconstruction = repmat(reconstruction,[n_index,1]);
    
    % result
    for i_index = 1:n_index
        for i_subject = 1:n_subject
            ii_subject = (model.grad.subject == u_subject(i_subject));
            ii_index   = model.grad.index{i_index};
            ii = (ii_subject & ii_index);
            data = struct_filter(model.grad.data,ii);
            pars = pair2struct([fieldnames(model.grad.origin),num2cell(model.grad.result.best{i_index}(i_subject).u_min')]');
            simulation = model.grad.simu(data,pars);
            reconstruction(i_index) = struct_set(reconstruction(i_index),simulation,ii);
        end
    end
    model.grad.result.reconstruction = reconstruction;
end

%% auxiliar
function x = add_row(x)
    x(1,:) = nan; % here we assume we work with numbers (no cells, strings or structs)
end