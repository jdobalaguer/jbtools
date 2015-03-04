
function cost = model_cost_mean(data,simu,pars)
    %% cost = MODEL_COST_MEAN(data,simu,pars)
    
    %% warnings
    
    %% assert
    
    %% function
    v_simu = mat2vec(simu.(pars.simu));
    cost   = nanmean(v_simu);
end