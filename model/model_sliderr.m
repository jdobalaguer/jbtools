
function model_sliderr(model)
    %% model = MODEL_SLIDERR(model)
    % plot the landscape of the cost function across parameters
    % see also: model_cost
    
    %% function
    
    % variables
    m = meeze(model.cost.result.cost,1);
    e = steeze(model.cost.result.cost,1);
    x = struct2cell(model.simu.pars);
    l = fieldnames(model.simu.pars);
    
    % figure
    fig_sliderr(m,e,x,l);
end
