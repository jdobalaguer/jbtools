
function scan = scan_ppi_append(scan)
    %% SCAN_PPI_APPEND()
    % append PPI regressors to the matrix design
    % see also scan_ppi_run

    %%  WARNINGS
    %#ok<*NUSED,*AGROW,*FPARK,*NASGU>
    
    %% ASSERT
    assert(strcmp(scan.glm.function,'hrf'));
    assert(all(scan.glm.hrf.ord==[0,0]));

    %% FUNCTION
    if ~scan.ppi.do.regression, return; end
    
    scan.ppi.variables.bid = {};
    scan.ppi.variables.regressor = {};
    
    for i_subject = 1:scan.subject.n
        scan.ppi.variables.bid{i_subject} = struct('name',{},'bid',{});
        
        subject = scan.subject.u(i_subject);
        file_SPM = sprintf('%ssub_%02i/SPM.mat',scan.dire.glm.firstlevel,subject);
        
        
        % load SPM
        SPM = load(file_SPM,'SPM');
        SPM = SPM.SPM;
        
        
        % get regressor names
        condglm = load(sprintf('%sfinal_condition_sub_%02i.mat',scan.dire.glm.regressor,scan.subject.u(i_subject)),'condition');
        condglm = condglm.condition{1};
        u_GLMname = {};
        u_SPMname = {};
        for i_condglm = 1:length(condglm)
            u_GLMname = [u_GLMname, {condglm{i_condglm}.name}, condglm{i_condglm}.subname];
            u_SPMname = [u_SPMname, {[condglm{i_condglm}.name,'\*bf']}, condglm{i_condglm}.subname];
        end
        n_name = length(u_GLMname);
        
        
        % get regressors
        regressor = {};
        for i_PPIname = 1:length(scan.ppi.cond)
            PPIname = scan.ppi.cond{i_PPIname};
            t_reg = [];
            for i_GLMname = 1:n_name
                GLMname = u_GLMname{i_GLMname};
                SPMname = u_SPMname{i_GLMname};
                SPMname = strrep(SPMname,'(','\(');
                SPMname = strrep(SPMname,')','\)');
                if ~strcmp(PPIname,GLMname), continue; end
                for i_xX = 1:length(SPM.xX.name)
                    if isempty(regexp(SPM.xX.name{i_xX},['.*',SPMname,'.*'],'match')), continue; end
                    t_reg(:,end+1) = SPM.xX.X(:,i_xX);
                end
            end
            regressor{i_PPIname} = t_reg;
        end
        scan.ppi.variables.regressor(i_subject,:) = regressor;
        
        
        % append seed
        j_bid = 1;
        scan.ppi.variables.bid{i_subject}(j_bid).name = 'seed';
        scan.ppi.variables.bid{i_subject}(j_bid).bid  = [];
        for i_session = 1:length(scan.ppi.variables.final{i_subject})
            SPM.xX.name{end+1} = sprintf('%s(%d)',scan.ppi.variables.bid{i_subject}(j_bid).name,i_session);
            SPM.xX.X(SPM.Sess(i_session).row,end+1)  = scan.ppi.variables.final{i_subject}{i_session};
            scan.ppi.variables.bid{i_subject}(j_bid).bid(end+1) = length(SPM.xX.name);
        end
        
        
        % append interactions
        for i_regressor = 1:length(scan.ppi.cond)
            j_bid = j_bid + 1;
            scan.ppi.variables.bid{i_subject}(j_bid).name = sprintf('PPI(%s)',scan.ppi.cond{i_regressor});
            scan.ppi.variables.bid{i_subject}(j_bid).bid  = [];
            for i_session = 1:length(scan.ppi.variables.final{i_subject})
                t_seed = mat2vec(scan.ppi.variables.final{i_subject}{i_session})';
                t_reg  = mat2vec(regressor{i_regressor}(SPM.Sess(i_session).row,i_session))';
                SPM.xX.name{end+1} = sprintf('PPI(%s(%d))',scan.ppi.variables.bid{i_subject}(j_bid).name,i_session);
                SPM.xX.X(SPM.Sess(i_session).row,end+1)  = t_seed .* t_reg;
                scan.ppi.variables.bid{i_subject}(j_bid).bid(end+1) = length(SPM.xX.name);
            end
        end
        
        
        % save SPM
        save(file_SPM,'SPM','-append');
        
    end
end
