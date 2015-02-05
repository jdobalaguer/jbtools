
function cost = model_cost_binary(data,simu,pars)
    %% cost = MODEL_COST_BINARY(data,simu,pars)
    
    %% warnings
    
    %% assert
    
    %% function
    v_data = mat2vec(logical(data.(pars.data)));
    v_simu = mat2vec(simu.(pars.simu));
    prob   = [v_simu(v_data) ; 1 - v_simu(~v_data)];
    geo    = geomean(0.01 + 0.99*prob);
    cost   = 1 - geo;
end