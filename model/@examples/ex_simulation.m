
%% load
load ~/dmt/gitmatlab/memrise/data/mat/nona2.mat

%% create struct
model = struct();

% simulation
model.simu.model    = @ex_model;
model.simu.pars     = struct('par1',1:10,'par2',1:10);
model.simu.data     = lang.s;
model.simu.subject  = lang.s.expt_subject;
model.simu.index    = {~lang.s.expt_feedback & ~lang.s.expt_evaluation};

%% run
model = model_simulation(model);
