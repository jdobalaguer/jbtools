
function cost = model_cost_dprime(data,simu,pars)
    %% cost = MODEL_COST_DPRIME(data,simu,pars)
    
    %% warnings
    
    %% assert
    
    %% function
    v_data = data.(pars.data);
    v_simu = simu.(pars.simu);
    cost = 0.5 * (geomean(1 - v_simu(v_data)) + geomean(v_simu(~v_data)));
end