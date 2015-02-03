
function model = model_min(model)
    %% model = MODEL_MIN(model)
    % find fitting with smaller cost
    % see also: model_cost
    
    %% warnings
    %#ok<*ASGLU>
    
    %% assert
    assert(isfield(model.simu,'result'), 'model_min: error. no "model.simu.result" field');
    assert(isfield(model.cost,'result'), 'model_min: error. no "model.cost.result" field');
    
    %% function

    % numbers
    n_subject   = size(model.cost.result.cost,1);
    n_index     = size(model.cost.result.cost,2);
    s_comb      = size(model.cost.result.cost); s_comb(1:2) = [];
    u_pars      = fieldnames(model.simu.pars);
    n_pars      = length(u_pars);
        
    % find minima subject
    model.cost.result.min_subject = cell(n_subject,n_index);
    cost = model.cost.result.cost;
    for i_subject = 1:n_subject
        for i_index = 1:n_index
            tmp_cost = reshape(cost(i_subject,i_index,:),s_comb);
            tmp_min  = struct();
            [tmp_min.i_min,tmp_min.v_min] = jb_findmin(tmp_cost);
            tmp_min.i_min(:,end+1:n_pars) = 1;
            tmp_min.u_min = nan(size(tmp_min.i_min));
            for i_pars = 1:n_pars
                tmp_min.u_min(:,i_pars) = model.simu.pars.(u_pars{i_pars})(tmp_min.i_min(:,i_pars));
            end
            model.cost.result.min_subject{i_subject,i_index} = tmp_min;
        end
    end
    
    % find minima group
    model.cost.result.min_group = cell(n_index,1);
    cost = mean(model.cost.result.cost,1);
    for i_index = 1:n_index
        tmp_cost = reshape(cost(1,i_index,:),s_comb);
        tmp_min  = struct();
        [tmp_min.i_min,tmp_min.v_min] = jb_findmin(tmp_cost);
        tmp_min.i_min(:,end+1:n_pars) = 1;
        tmp_min.u_min = nan(size(tmp_min.i_min));
        for i_pars = 1:n_pars
            tmp_min.u_min(:,i_pars) = model.simu.pars.(u_pars{i_pars})(tmp_min.i_min(:,i_pars));
        end
        model.cost.result.min_group{i_index,1} = tmp_min;
    end
    

end
