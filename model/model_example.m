
function model = model_example()
    %% model = model_example()
    % example showing how to use the toolbox

    %% warnings
    %#ok<*INUSL,*INUSD>

    %% function
    N =  4;
    t =  5;
    k = 10;
    
    model = struct();
    data.subject = mat2vec(repmat(1:N,[t,1]));
   data.noise   = mat2vec(randn(t,N));

    % exhaustive search
    model.simu.func     = @test_simufunc;
    model.simu.pars     = struct('a',linspace(-1,+1,k),...
                                 'b',linspace(-1,+1,k),...
                                 'c',linspace(-1,+1,k));
    model.simu.data     = data;
    model.simu.subject  = data.subject;
    model = model_simulation(model);
    model = model_reconstruction(model);

    model.cost.func     = @test_costfunc;
    model.cost.pars     = struct();
    model.cost.simu     = {1};
    model.cost.index    = model.simu.index;
    model = model_cost(model);
    model = model_minimum(model);

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
    a = pars.a;
    b = pars.b;
    c = pars.c;
    n = data.noise;
    result.cost = n + mean(power([a;b;c],2));
    result.pars = pars;
    result.data = data;
end

%% cost function
function cost = test_costfunc(data,simu,pars)
    cost = mean(simu.cost);
end