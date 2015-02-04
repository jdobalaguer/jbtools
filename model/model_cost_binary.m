
function cost = model_cost_binary(data,simu,pars)
    %% cost = MODEL_COST_BINARY(data,simu,pars)
    
    %% warnings
    
    %% assert
    
    %% function
    v_data = mat2vec(data.(pars.data));
    v_simu = mat2vec(simu.(pars.simu));
    cost = geomean([1 - v_simu(v_data);v_simu(~v_data)]);
end