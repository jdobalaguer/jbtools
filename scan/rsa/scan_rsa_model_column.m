
function scan = scan_rsa_model_column(scan)
    %% scan = SCAN_RSA_MODEL_COLUMN(scan)
    % build columns for the model
    % to list main functions, try
    %   >> help scan;
    
    %% function
    if ~scan.running.flag.model, return; end
    
    % build columns
    for i_model = 1:length(scan.job.model)
        scan.running.model(i_model).column = struct('subject',{},'session',{},'name',{},'onset',{},'level',{});
        
        % variables
        x_column = scan.running.load;
        
        % columns
        j_column = 0;
        for i_subject = 1:scan.running.subject.number
            ii_subject = (x_column.subject == scan.running.subject.unique(i_subject));
            [u_session,n_session] = numbers(scan.running.subject.session{i_subject});
            for i_session = 1:n_session
                ii_session = (x_column.session == u_session(i_session));
                for i_condition = 1:length(scan.job.glm.condition)
                    for i_order = 1:length(scan.job.glm.order)
                        ii_condition = strcmp(x_column.name,scan.job.glm.condition{i_condition});
                        f_column = find(ii_subject & ii_session & ii_condition);
                        for i_column = 1:length(f_column)
                            j_column = j_column + 1;
                            scan.running.model(i_model).column(j_column).subject = x_column.subject(f_column(i_column));
                            scan.running.model(i_model).column(j_column).session = x_column.session(f_column(i_column));
                            scan.running.model(i_model).column(j_column).order   = x_column.order(f_column(i_column));
                            scan.running.model(i_model).column(j_column).name    = x_column.name{f_column(i_column)};
                            scan.running.model(i_model).column(j_column).onset   = x_column.onset(f_column(i_column));
                            for i_level = 1:length(scan.running.model(i_model).level{i_subject}{i_session}{i_condition})
                                scan_tool_assert(scan,length(f_column) == length(scan.running.model(i_model).level{i_subject}{i_session}{i_condition}{i_level}.value),'[scan.running.load] and [scan.running.model.level] do not match');
                                scan.running.model(i_model).column(j_column).level.(scan.running.model(i_model).level{i_subject}{i_session}{i_condition}{i_level}.name) = scan.running.model(i_model).level{i_subject}{i_session}{i_condition}{i_level}.value(i_column);
                            end
                        end
                    end
                end
            end
        end
    end
end
