
function model = model_min(model)
    %% model = MODEL_MIN(model)
    
    %% warnings
    %#ok<*ASGLU>
    
    %% assert
    assert(isfield(model.simu,'result'), 'model_min: error. no "model.simu.result" field');
    assert(isfield(model.cost,'result'), 'model_min: error. no "model.cost.result" field');
    
    %% function

    % find minima subject
    [model.cost.result.min_subject.i_min,model.cost.result.min_subject.v_min] = jb_findmin(model.cost.result.cost);
    model.cost.result.min_subject.u_min = nan(size(model.cost.result.min_subject.i_min));

    u_sub = unique(model.simu.subject);
    model.cost.result.min_subject.u_min(:,1) = u_sub(model.cost.result.min_subject.i_min(:,1));
    
    u_min = fieldnames(model.simu.pars);
    n_min = length(u_min);
    
    model.cost.result.min_subject.i_min(:,end+1:n_min+2) = 1;
    
    for i_min = 1:n_min
        model.simu.pars.(u_min{i_min})(model.cost.result.min_subject.i_min(:,i_min+2));
        model.cost.result.min_subject.u_min(:,i_min+2) = model.simu.pars.(u_min{i_min})(model.cost.result.min_subject.i_min(:,i_min+2));
    end
    
    % find minima group
    [model.cost.result.min_group.i_min,model.cost.result.min_group.v_min] = jb_findmin(mean(model.cost.result.cost,1));
    model.cost.result.min_group.u_min = nan(size(model.cost.result.min_group.i_min));

    u_min = fieldnames(model.simu.pars);
    n_min = length(u_min);
    
    model.cost.result.min_group.i_min(:,end+1:n_min+2) = 1;
    
    for i_min = 1:n_min
        model.simu.pars.(u_min{i_min})(model.cost.result.min_group.i_min(:,i_min+2));
        model.cost.result.min_group.u_min(:,i_min+2) = model.simu.pars.(u_min{i_min})(model.cost.result.min_group.i_min(:,i_min+2));
    end

end
