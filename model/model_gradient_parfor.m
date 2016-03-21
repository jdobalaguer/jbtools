
function result = model_gradient_parfor(problem,parfor_x0,parfor_simu_pars,parfor_simu_func,parfor_cost_pars,parfor_cost_func,parfor_data)

    %% function
    
    % problem
    problem.x0        = parfor_x0';
    problem.objective = @cost_function;

    % fminsearch
    result   = struct('u_min',{nan(size(parfor_x0))},'v_min',{inf});
    exitflag = +1; %#ok<NASGU>
    try     [result.u_min,result.v_min,exitflag] = feval(problem.solver,problem);
    catch,  exitflag = -1;
    end
    assertWarning(exitflag > 0,'model_gradient_parfor: error. search not possible \n');

    %% nested
    function cost = cost_function(x)
        pars = [parfor_simu_pars';num2cell(x)];
        pars = struct(pars{:});
        simu = parfor_simu_func(parfor_data,pars);
        cost = parfor_cost_func(parfor_data,simu,parfor_cost_pars);
    end 
end

