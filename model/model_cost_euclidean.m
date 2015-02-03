
function cost = model_cost_euclidean(data,simu,pars)
    %% cost = model_cost_euclidean(data,simu,pars)
    
    %% warnings
    
    %% assert
    
    %% function
    v_data = data.(pars.data);
    v_simu = simu.(pars.simu);
    
    cost = sqrt(mean(power(v_data-v_simu,2)));
end