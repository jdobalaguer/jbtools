
function model = model_example()
    %% model = model_example()
    % example showing how to use the toolbox

    %% warnings

    %% function
    N = 1;
    k = 20;
    
    model = struct();
    data.subject = (1:N)';
    data.noise   = randn(N,1);

    % exhaustive search
    model.simu.func     = @test_simufunc;
    model.simu.pars     = struct('a',linspace(-1,+1,k),...
                                 'b',linspace(-1,+1,k),...
                                 'c',linspace(-1,+1,k));
    model.simu.data     = data;
    model.simu.subject  = data.subject;
    model = model_simulation(model);

    model.cost.func     = @test_costfunc;
    model.cost.pars     = struct();
    model.cost.simu     = {1};
    model.cost.index    = model.simu.index;
    model = model_cost(model);
    model = model_min(model);

    % plot grid
    model_landscape(model,{{'a'},{'a','b'},{'a','b','c'}});

    % gradient descent
    model.grad.data     = data;
    model.grad.simu     = @test_simufunc;
    model.grad.cost     = @test_costfunc;
    model.grad.origin   = struct('a',0:1,'b',0:1,'c',0:1);
    model.grad.subject  = data.subject;
    model = model_gradient(model);
end

%% model
function result = test_simufunc(data,pars)
    result.pars = [data.noise,pars.a,pars.b,pars.c];
end

%% cost function
function cost = test_costfunc(~,simu,~)
    cost = mod(5*sqrt(mean(power(simu.pars,2))),1);
end