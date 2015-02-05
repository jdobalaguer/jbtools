
function result = model_gradient_parfor(problem,parfor_x0,parfor_pars,parfor_simu,parfor_cost,parfor_data)

    %% function
    
    % problem
    problem.x0        = parfor_x0;
    problem.objective = @cost_function;

    % fminsearch
    result = struct();
    [result.u_min,result.v_min,exitflag] = fminsearch(problem);
    assert(exitflag > 0,'model_gradient: error. limit iteration reached \n');

    %% nested
    function cost = cost_function(x)
        pars = [parfor_pars';num2cell(x)'];
        pars = struct(pars{:});
        simu = parfor_simu(parfor_data,pars);
        cost = parfor_cost(parfor_data,simu);
    end 
end

