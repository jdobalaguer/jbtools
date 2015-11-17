
function model = model_example()
    %% model = model_example()
    % example showing how to use the toolbox

    %% function

    % parameters
    N = 4; % number of subjects
    t = 5; % number of trials
    k = 7; % points per parameter (in exhaustive grid search)
    
    % data
    data.subject = mat2vec(repmat(1:N,[t,1]));
    data.noise   = mat2vec(randn(t,N));

    % EXHAUSTIVE SEARCH METHOD
    model = struct();
    model.simu.func     = @test_simufunc;
    model.simu.pars     = struct('a',linspace(-1,+1,k),...
                                 'b',linspace(-1,+1,k),...
                                 'c',linspace(-1,+1,k),...
                                 'd',linspace(-1,+1,k));
    model.simu.data     = data;
    model.simu.subject  = data.subject;
    model = model_simulation(model);     % get model preditions
    model = model_reconstruction(model); % merge predictions across subjets

    % define cost
    model.cost.func     = @test_costfunc;
    model.cost.pars     = struct();
    model.cost.simu     = {1};
    model.cost.index    = model.simu.index;
    model = model_cost(model);      % calculate the cost for each subject/parameter
    model = model_minimum(model);   % find global minimum in the grid

    % many ways of plotting grids
    model_landscape(model,{{'a'},{'a','b'},{'a','b','c'}});
    model_slider(model);
    model_sliderr(model);

    % GRADIENT DESCENT METHOD
    model.grad.data     = data;
    model.grad.simu     = @test_simufunc;
    model.grad.origin   = struct('a',0:1,'b',0:1,'c',0:1,'d',0:1);
    model.grad.costfunc = @test_costfunc;
    model.grad.costpars = struct();
    model.grad.subject  = data.subject;
    model = model_gradient(model);
end

%% model
function result = test_simufunc(data,pars)
    a = pars.a;
    b = pars.b;
    c = pars.c;
    d = pars.d;
    n = data.noise;
    result.cost = n + mean(power([a;b;c;d],2));
end

%% cost function
function cost = test_costfunc(data,simu,pars)
    cost = mean(simu.cost);
end