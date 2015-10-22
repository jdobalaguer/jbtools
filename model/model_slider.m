
function model_slider(model)
    %% model = MODEL_SLIDER(model)
    % plot the landscape of the cost function across parameters
    % see also: model_cost
    
    %% function
    
    % variables
    m = meeze(model.cost.result.cost,1);
    x = struct2cell(model.simu.pars);
    l = fieldnames(model.simu.pars);
    
    % figure
    fig_slider(m,x,l);
end
