
function model = model_xval(model)
    %% model = MODEL_XVAL(model)
    % calculate the cross-validated fitting
    % this can work in parallel: use @mme_open
    % see also: model_simulation
    
    %% function
    
    % assert
    assert(struct_isfield(model,'simu.result.simulation'),         'model_xval: error. no "model.simu.result.simulation" field');
    assert(length(model.xval.block) == length(model.simu.subject), 'model_xval: error. "model.xval.block" and "model.simu.subject" have different length');
    assert(length(model.xval.index) == length(model.xval.simu),    'model_xval: error. "model.xval.index" and "model.simu.simu" have different length');
    
    % default
    func_default('model.xval.leave',1);
    
    % numbers
    u_pars  = fieldnames(model.simu.pars);
    n_pars  = length(u_pars);
    s_comb  = size(model.simu.result.simulation); s_comb(1:2) = []; s_comb(end+1:n_pars) = 1;
    n_comb  = prod(s_comb);
    [u_subject,n_subject] = numbers(model.simu.subject);
    n_index = length(model.xval.index);
    
    % initialise variables
    model.xval.result = struct('training',{},'evaluate',{});
    
    fw = func_wait(n_index * n_subject);
    for i_index = 1:n_index

        % indices
        i_simu  = model.xval.simu{i_index};
        ii_simu     = model.simu.index{i_simu};
        ii_index    = model.xval.index{i_index};
        [u_block,n_block] = numbers(model.xval.block(ii_simu & ii_index));
        
        % datasets
        xval_training = combnk(u_block,n_block - model.xval.leave);
        if isvector(xval_training), xval_training = mat2vec(xval_training); end
        xval_training = mat2cell(xval_training,ones(size(xval_training,1),1));
        xval_evaluate = cellfun(@(t) u_block(~ismember(u_block,t)),xval_training,'UniformOutput',false);
        n_xval = numel(xval_training);

        % initialise variables
        model.xval.result(i_index).training.cost = nan([n_subject,n_xval,s_comb],'single');
        model.xval.result(i_index).training.min  = repmat(struct('i',{[]},'u',{[]},'v',{[]}),[n_subject,n_xval]);
        model.xval.result(i_index).evaluate.cost = nan([n_subject,n_xval,s_comb],'single');
        model.xval.result(i_index).evaluate.min  = repmat(struct('i',{[]},'u',{[]},'v',{[]}),[n_subject,n_xval]);
        
        % cross-validation
        for i_subject = 1:n_subject

            % subject
            subject = u_subject(i_subject);
            ii_subject = (model.simu.subject == subject);

            for i_xval = 1:n_xval

                % cross-validation indices
                i_simu  = model.xval.simu{i_index};
                ii_simu     = model.simu.index{i_simu};
                ii_index    = model.xval.index{i_index};
                ii_training = ismember(model.xval.block,xval_training{i_xval});
                ii_evaluate = ismember(model.xval.block,xval_evaluate{i_xval});
                assert(any(ii_simu & ii_index & ii_subject & ii_training),'model_xval: error. simu or index (%d) doesnt cover training',model.xval.simu{i_index});
                assert(any(ii_simu & ii_index & ii_subject & ii_evaluate),'model_xval: error. simu or index (%d) doesnt cover evaluation',model.xval.simu{i_index});

                % training cost (based on @model_cost)
                data = struct_filter(model.simu.data,ii_simu & ii_index & ii_subject & ii_training);
                pars = model.xval.pars;
                parfor_simu   = model.simu.result.simulation(i_subject,i_simu,:);
                parfor_ii     = logical(ii_training(ii_simu & ii_index & ii_subject));
                parfor_result = model.xval.result(i_index).training.cost(i_subject,i_xval,:);
                parfor_func   = model.xval.func;
                parfor (i_comb = 1:n_comb, mme_size())
                    simu = struct_filter(parfor_simu(i_comb),parfor_ii);
                    parfor_result(i_comb) = parfor_func(data,simu,pars); %#ok<PFBNS>
                end
                model.xval.result(i_index).training.cost(i_subject,i_xval,:) = parfor_result;

                % training min (based on @model_minimisation)
                tmp_cost = mat_reshape(parfor_result,s_comb);
                tmp_min  = model.xval.result(i_index).training.min(i_subject,i_xval);
                [tmp_min.i,tmp_min.v] = jb_findmin(tmp_cost);
                tmp_min.i(:,end+1:n_pars) = 1;
                tmp_min.u = nan(size(tmp_min.i));
                for i_pars = 1:n_pars
                    tmp_min.u(:,i_pars) = model.simu.pars.(u_pars{i_pars})(tmp_min.i(:,i_pars));
                end
                model.xval.result(i_index).training.min(i_subject,i_xval) = tmp_min;

                % evaluate cost (based on @model_cost)
                data = struct_filter(model.simu.data,ii_simu & ii_index & ii_subject & ii_evaluate);
                pars = model.xval.pars;
                parfor_simu   = model.simu.result.simulation(i_subject,i_simu,:);
                parfor_ii     = logical(ii_evaluate(ii_simu & ii_index & ii_subject));
                parfor_result = model.xval.result(i_index).evaluate.cost(i_subject,i_xval,:);
                parfor_func   = model.xval.func;
                parfor (i_comb = 1:n_comb, mme_size())
                    simu = struct_filter(parfor_simu(i_comb),parfor_ii);
                    parfor_result(i_comb) = parfor_func(data,simu,pars); %#ok<PFBNS>
                end
                model.xval.result(i_index).evaluate.cost(i_subject,i_xval,:) = parfor_result;

                % evaluate min (based on @model_minimisation)
                tmp_cost  = mat_reshape(parfor_result,s_comb);
                tmp_min   = model.xval.result(i_index).training.min(i_subject,i_xval);
                for i_min = 1:size(tmp_min.i,1)
                    i_comb             = num2cell(tmp_min.i(i_min,:));
                    tmp_min.v(i_min,1) = tmp_cost(i_comb{:});
                end
                model.xval.result(i_index).evaluate.min(i_subject,i_xval) = tmp_min;
            end
            
            % wait
            func_wait([],fw);
        end
    end
    func_wait(0,fw);
end
