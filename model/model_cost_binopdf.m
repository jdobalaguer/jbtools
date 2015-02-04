
function cost = model_cost_binopdf(data,simu,pars)
    %% cost = model_cost_euclidean(data,simu,pars)
    
    %% warnings
    
    %% assert
    
    
    %% function
    v_data = data.(pars.data);
    v_simu = simu.(pars.simu);
    
    frame_sum  = length(v_simu);
    model_sum  = round(sum(v_simu));
    human_mean = nanmean(v_data);
    likelihood = 0.05 + 0.95 *binopdf(model_sum,frame_sum,human_mean);

    cost = 1 - log(likelihood);
end