
function scan = scan_glm_matrix(scan)
    %% scan = SCAN_GLM_MATRIX(scan)
    % set running matrix
    % to list main functions, try
    %   >> help scan;

    %% function
    if scan_tool_isdone(scan), return; end
    if ~scan.running.flag.design, return; end
    
    % print
    scan_tool_print(scan,false,'\nSet matrix : ');
    scan = scan_tool_progress(scan,scan.running.subject.number);
    
    % subject
    for i_subject = 1:scan.running.subject.number
        
        % SPM and variables
        SPM = file_loadvar(fullfile(scan.running.directory.original.first{i_subject},'SPM.mat'),'SPM');
        n_volume = cellfun(@length,scan.running.file.nii.epi3.(scan.job.image){i_subject});
        n_order  = SPM.xBF.order;
        
        % matrix
        scan.running.design(i_subject).matrix          = SPM.xX.X;
        
        % row
        scan.running.design(i_subject).row.file        = cellstr(SPM.xY.P);
        scan.running.design(i_subject).row.session     = [];
        scan.running.design(i_subject).row.number      = size(scan.running.design(i_subject).matrix,1);
        [u_session,n_session] = numbers(scan.running.subject.session{i_subject});
        for i_session = 1:n_session
            scan.running.design(i_subject).row.session(end+1:end+n_volume(i_session),1) = u_session(i_session);
        end
        
        % column
        scan.running.design(i_subject).column = struct('main',{{}},'name',{{}},'version',{{}},'session',{[]},'order',{[]},'covariate',{[]},'number',{size(scan.running.design(i_subject).matrix,2)});
        j_column = 0;
        [u_session,n_session] = numbers(scan.running.subject.session{i_subject});
        for i_session = 1:n_session
            % condition
            for i_condition = 1:length(scan.running.condition{i_subject}{i_session})
                for i_order = 1:n_order
                    j_column = j_column + 1;
                    scan.running.design(i_subject).column.main{j_column}      = scan.running.condition{i_subject}{i_session}(i_condition).main;
                    scan.running.design(i_subject).column.name{j_column}      = scan.running.condition{i_subject}{i_session}(i_condition).name;
                    scan.running.design(i_subject).column.version{j_column}   = scan.running.condition{i_subject}{i_session}(i_condition).version;
                    scan.running.design(i_subject).column.session(j_column)   = u_session(i_session);
                    scan.running.design(i_subject).column.order(j_column)     = i_order;
                    scan.running.design(i_subject).column.covariate(j_column) = false;
                end
                for i_level = 1:length(scan.running.condition{i_subject}{i_session}(i_condition).subname)
                    for i_order = 1:n_order
                        j_column = j_column + 1;
                        scan.running.design(i_subject).column.main{j_column}      = scan.running.condition{i_subject}{i_session}(i_condition).main;
                        scan.running.design(i_subject).column.name{j_column}      = scan.running.condition{i_subject}{i_session}(i_condition).subname{i_level};
                        scan.running.design(i_subject).column.version{j_column}   = scan.running.condition{i_subject}{i_session}(i_condition).version;
                        scan.running.design(i_subject).column.session(j_column)   = u_session(i_session);
                        scan.running.design(i_subject).column.order(j_column)     = i_order;
                        scan.running.design(i_subject).column.covariate(j_column) = false;
                    end
                end
            end
            % regressor
            for i_regressor = 1:length(scan.running.regressor{i_subject}{i_session}.name)
                j_column = j_column + 1;
                scan.running.design(i_subject).column.main{j_column}      = scan.running.regressor{i_subject}{i_session}.name{i_regressor};
                scan.running.design(i_subject).column.name{j_column}      = scan.running.regressor{i_subject}{i_session}.name{i_regressor};
                scan.running.design(i_subject).column.version{j_column}   = '';
                scan.running.design(i_subject).column.session(j_column)   = u_session(i_session);
                scan.running.design(i_subject).column.order(j_column)     = 0;
                scan.running.design(i_subject).column.covariate(j_column) = scan.running.regressor{i_subject}{i_session}.covariate(i_regressor);
            end
        end
        % constant
        for i_constant = 1:length(SPM.xX.iB)
            j_column = j_column + 1;
            scan.running.design(i_subject).column.main{j_column}      = 'constant';
            scan.running.design(i_subject).column.name{j_column}      = 'constant';
            scan.running.design(i_subject).column.version{j_column}   = '';
            scan.running.design(i_subject).column.session(j_column)   = u_session(i_session);
            scan.running.design(i_subject).column.order(j_column)     = 0;
            scan.running.design(i_subject).column.covariate(j_column) = true;
        end
        
        % wait
        scan = scan_tool_progress(scan,[]);
    end
    scan = scan_tool_progress(scan,0);
    
    % done
    scan = scan_tool_done(scan);
end
