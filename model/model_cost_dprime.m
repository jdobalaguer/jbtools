
function cost = model_cost_dprime(data,simu,pars)
    %% cost = MODEL_COST_DPRIME(data,simu,pars)
    
    %% warnings
    
    %% assert
    
    %% function
    v_data = data.(pars.data);
    v_simu = simu.(pars.simu);
    
    cost = 0.5 * (1 - nanmean(v_simu(v_data == 1)) + nanmean(v_simu(v_data == 0)));
end