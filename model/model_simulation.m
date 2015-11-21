
function model = model_simulation(model)
    %% model = model_simulation(model)
    % run a (grid of) simulation(s) of a model
    % this can work in parallel. @use mme_open
    % to list main functions, try
    %   >> help model;
    
    %% warnings
    %#ok<*PFBNS>

    %% function
    
    % set up parameters
    if ~struct_isfield(model,'simu.pars') || struct_isempty(model.simu.pars)
        model.simu.pars = struct('null',0);
    end
    model.simu.pars = struct_mat2vec(model.simu.pars);
    u_pars = fieldnames(model.simu.pars);
    n_pars = length(u_pars);
    c_pars = cell(1,n_pars);
    for i_pars = 1:n_pars
        c_pars{i_pars} =  model.simu.pars.(u_pars{i_pars});
        if ~iscell(c_pars{i_pars}), c_pars{i_pars} = num2cell(c_pars{i_pars}); end % convert to cell
    end
    u_comb = fliplr(vec_combination(c_pars{end:-1:1}));
    n_comb = size(u_comb,1);
    s_comb = cellfun(@numel,c_pars);

    % subject
    [u_subject,n_subject] = numbers(model.simu.subject);
    
    % index
    if ~struct_isfield(model.simu,'index'), model.simu.index = {ones(size(model.simu.subject))}; end
    u_index = model.simu.index;
    n_index = length(u_index);
    
    % initialize result
    data = struct_filter(model.simu.data,[]);
    pars = [u_pars';num2cell(u_comb(1,:))];
    pars = struct(pars{:});
    model.simu.result.simulation = model.simu.func(data,pars);
    u_result = fieldnames(model.simu.result.simulation);
    n_result = length(u_result);
    for i_result = 1:n_result
        model.simu.result.simulation.(u_result{i_result}) = [];
    end
    model.simu.result.simulation = repmat(model.simu.result.simulation,[n_subject,n_index,s_comb]);
    
    % simulations
    fw = func_wait(n_subject * n_index * n_comb);
    for i_subject = 1:n_subject

        % subject
        subject = u_subject(i_subject);
        ii_subject = (model.simu.subject == subject);
        for i_index = 1:n_index
                
            % index
            ii_index   = u_index{i_index};
            ii = (ii_subject & ii_index);
            
            % data
            data = struct_filter(model.simu.data,ii);
            
            % parfor
            parfor_result = model.simu.result.simulation(i_subject,i_index,:);
            parfor_func   = model.simu.func;
            parfor (i_comb = 1:n_comb, mme_size())
                
                % comb
                pars = [u_pars';num2cell(u_comb(i_comb,:))];
                pars = struct(pars{:});
                
                % run
                parfor_result(i_comb) = parfor_func(data,pars);
                
                % progress
                func_wait([],fw);
            end
            model.simu.result.simulation(i_subject,i_index,:) = parfor_result;
        end
    end
    func_wait(0,fw);

end