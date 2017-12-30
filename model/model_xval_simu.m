
function model = model_xval_simu(model)
    %% model = MODEL_XVAL_SIMU(model)
    % calculate the cross-validated fitting
    % this can work in parallel: use @mme_open
    % see also: model_simulation
    
    %% notes
    % find the best way to parallelise this
    
    %% function
    
    % assert
    assert(struct_isfield(model,'simu.result.simulation'),              'model_xval: error. no "model.simu.result.simulation" field');
    assert(length(model.simuxval.block) == length(model.simu.subject),  'model_xval: error. "model.simuxval.block" and "model.simu.subject" have different length');
    assert(length(model.simuxval.index) == length(model.simuxval.simu), 'model_xval: error. "model.simuxval.index" and "model.simu.simu" have different length');
    
    % default
    func_default('model.simuxval.leave',1);
    
    % numbers
    u_pars  = fieldnames(model.simu.pars);
    n_pars  = length(u_pars);
    s_comb  = size(model.simu.result.simulation); s_comb(1:2) = []; s_comb(end+1:n_pars) = 1;
    n_comb  = prod(s_comb);
    [u_subject,n_subject] = numbers(model.simu.subject);
    n_index = length(model.simuxval.index);
    
    % initialise variables
    model.simuxval.result = struct('training',{},'evaluate',{});
    
    for i_index = 1:n_index

        % indices
        i_simu  = model.simuxval.simu{i_index};
        ii_simu     = model.simu.index{i_simu};
        ii_index    = model.simuxval.index{i_index};
        [u_block,n_block] = numbers(model.simuxval.block(ii_simu & ii_index));
        
        % datasets
        xval_training = combnk(u_block,n_block - model.simuxval.leave);
        if isvector(xval_training), xval_training = mat2vec(xval_training); end
        xval_training = mat2cell(xval_training,ones(size(xval_training,1),1));
        xval_evaluate = cellfun(@(t) u_block(~ismember(u_block,t)),xval_training,'UniformOutput',false);
        n_xval = numel(xval_training);

        % initialise variables
        model.simuxval.result(i_index).training.cost = nan([n_subject,n_xval,s_comb],'single');
        model.simuxval.result(i_index).training.min  = repmat(struct('i',{[]},'u',{[]},'v',{[]}),[n_subject,n_xval]);
        model.simuxval.result(i_index).evaluate.cost = nan([n_subject,n_xval,s_comb],'single');
        model.simuxval.result(i_index).evaluate.min  = repmat(struct('i',{[]},'u',{[]},'v',{[]}),[n_subject,n_xval]);
        
        % wait
        fw = func_wait(n_subject * n_xval);
        
        % cross-validation
        for i_subject = 1:n_subject
            for i_xval = 1:n_xval
                
                % subject
                subject = u_subject(i_subject);
                ii_subject = (model.simu.subject == subject);

                % cross-validation indices
                i_simu  = model.simuxval.simu{i_index};
                ii_simu     = model.simu.index{i_simu};
                ii_index    = model.simuxval.index{i_index};
                ii_training = ismember(model.simuxval.block,xval_training{i_xval});
                ii_evaluate = ismember(model.simuxval.block,xval_evaluate{i_xval});
                assert(any(ii_simu & ii_index & ii_subject & ii_training),'model_xval: error. simu or index (%d) doesnt cover training',model.simuxval.simu{i_index});
                assert(any(ii_simu & ii_index & ii_subject & ii_evaluate),'model_xval: error. simu or index (%d) doesnt cover evaluation',model.simuxval.simu{i_index});

                % training cost (based on @model_cost)
                data = struct_filter(model.simu.data,ii_simu & ii_index & ii_subject & ii_training);
                pars = model.simuxval.pars;
                comb_simu   = model.simu.result.simulation(i_subject,i_simu,:);
                comb_ii     = logical(ii_training(ii_simu & ii_index & ii_subject));
                comb_result = model.simuxval.result(i_index).training.cost(i_subject,i_xval,:);
                comb_func   = model.simuxval.func;
                for i_comb = 1:n_comb
                    simu = struct_filter(comb_simu(i_comb),comb_ii);
                    comb_result(i_comb) = comb_func(data,simu,pars);
                end
                model.simuxval.result(i_index).training.cost(i_subject,i_xval,:) = comb_result;

                % training min (based on @model_minimum)
                tmp_cost = mat_reshape(comb_result,s_comb);
                tmp_min  = model.simuxval.result(i_index).training.min(i_subject,i_xval);
                [tmp_min.i,tmp_min.v] = jb_findmin(tmp_cost);
                tmp_min.i(:,end+1:n_pars) = 1;
                tmp_min.u = nan(size(tmp_min.i));
                for i_pars = 1:n_pars
                    tmp_min.u(:,i_pars) = model.simu.pars.(u_pars{i_pars})(tmp_min.i(:,i_pars));
                end
                model.simuxval.result(i_index).training.min(i_subject,i_xval) = tmp_min;

                % evaluate cost (based on @model_cost)
                data = struct_filter(model.simu.data,ii_simu & ii_index & ii_subject & ii_evaluate);
                pars = model.simuxval.pars;
                comb_simu   = model.simu.result.simulation(i_subject,i_simu,:);
                comb_ii     = logical(ii_evaluate(ii_simu & ii_index & ii_subject));
                comb_result = model.simuxval.result(i_index).evaluate.cost(i_subject,i_xval,:);
                comb_func   = model.simuxval.func;
                for i_comb = 1:n_comb
                    simu = struct_filter(comb_simu(i_comb),comb_ii);
                    comb_result(i_comb) = comb_func(data,simu,pars);
                end
                model.simuxval.result(i_index).evaluate.cost(i_subject,i_xval,:) = comb_result;

                % evaluate min (based on @model_minimum)
                tmp_cost  = mat_reshape(comb_result,s_comb);
                tmp_min   = model.simuxval.result(i_index).training.min(i_subject,i_xval);
                for i_min = 1:size(tmp_min.i,1)
                    i_comb             = num2cell(tmp_min.i(i_min,:));
                    tmp_min.v(i_min,1) = tmp_cost(i_comb{:});
                end
                model.simuxval.result(i_index).evaluate.min(i_subject,i_xval) = tmp_min;
                
                % wait
                func_wait([],fw);
            end
        end
        func_wait(0,fw);
    end
end
