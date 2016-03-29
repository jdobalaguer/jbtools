
function result = model_gradient_parfor(problem,parfor_x0,parfor_simu_pars,parfor_simu_func,parfor_cost_pars,parfor_cost_func,parfor_data)

    %% function
    
    % problem
    problem.x0        = parfor_x0;
    problem.objective = @cost_function;

    % fminsearch
    result   = struct('u_min',{parfor_x0},'v_min',{inf});
    exitflag = +1; %#ok<NASGU>
    parfor_v0 = cost_function(parfor_x0);
    if isinf(nan2inf(parfor_v0))
        return
    else
        try
            [result.u_min,result.v_min,exitflag] = feval(problem.solver,problem);
            if all(result.u_min == parfor_x0)
                error('stuck at initial point');
            end
        catch err
            exitflag = -1;
            fprintf('model_gradient_parfor: error. "%s" \n',err.message);
            fprintf('model_gradient_parfor: error. V(X0) = %d \n',parfor_v0);
        end
        assertWarning(exitflag > 0,'model_gradient_parfor: error. search not possible \n');
    end

    %% nested
    function cost = cost_function(x)
        pars = [parfor_simu_pars';num2cell(x')];
        pars = struct(pars{:});
        simu = parfor_simu_func(parfor_data,pars);
        cost = parfor_cost_func(parfor_data,simu,parfor_cost_pars);
    end 
end

