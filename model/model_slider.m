
function model_slider(model)
    %% model = MODEL_SLIDER(model)
    % plot the landscape of the cost function across parameters
    % see also: model_cost
    
    %% function
    
    % variables
    v = model.cost.result.cost;
    x = struct2cell(model.simu.pars);
    l = fieldnames(model.simu.pars);
    
    % average across subjects
    s = size(v); s(1) = [];
    m = reshape(nanmean(v,1),s);
    
    % set index
    x{end+1} = mat2vec(1:size(v,2));
    l{end+1} = 'index';
    m = permute(m,[2:ndims(m),1]);
    
    % reshape (in case there was any scalar parameter)
    m = reshape(m,mat2row([cellfun(@numel,struct2cell(model.simu.pars));length(model.cost.index)]));
    
    % figure
    fig_slider(m,x,l);
end
