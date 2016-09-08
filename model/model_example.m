
function model = model_example()
    %% model = MODEL_EXAMPLE()
    % example code showing how to use the toolbox
    % it includes an exhaustive simulation
    %             best fitting minimisation
    %             cross-validation prediction
    %             gradient-descent (fmincon)

    %% function

    % parameters
    N = 2; % number of subjects
    b = 3; % number of blocks
    t = 4; % number of trials
    k = 5; % points per parameter (in exhaustive grid search)
    
    % data
    data.subject = mat2vec(repmat(1:N,[b*t,1]));
    data.block   = mat2vec(repmat(permat(1:b,[1,t]),[1,N]));
    data.trial   = mat2vec(repmat(1:t,[1,b*N]));
    data.noise   = mat2vec(randn(N*b*t,1));

    % EXHAUSTIVE SIMULATION
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

    % EXHAUSTIVE COST MINIMSATION
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
    
    % EXHAUSTIVE CROSS-VALIDATION
    model.xval.func     = @test_costfunc;
    model.xval.pars     = struct();
    model.xval.simu     = {1};
    model.xval.index    = model.simu.index;
    model.xval.block    = data.block;
    model.xval.leave    = 1; % leave-one-out
    model = model_xval(model);
    
    % BAYES/MAP PREDICTIONS
    % this would require the cost to be a likelihood function
    model.bayes.func    = 'negative log-likelihood';
    % model = model_bayes(model);

    % GRADIENT DESCENT METHOD
    model.grad.data     = data;
    model.grad.simu     = @test_simufunc;
    model.grad.origin   = struct('a',{0:1},'b',{0:1},'c',{0:1},'d',{0:1});
    model.grad.costfunc = @test_costfunc;
    model.grad.costpars = struct();
    model.grad.subject  = data.subject;
    model.grad.search   = struct('solver',{'fminsearch'},'options',{[]});
    model = model_gradient(model);
end

%% simulation function
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