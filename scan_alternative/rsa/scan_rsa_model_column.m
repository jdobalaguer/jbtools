
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
        s_column = length(x_column.subject);
        x_subname = scan.running.model(i_model).level.name;
        s_subname = length(x_subname);
        if ~s_subname,  x_level = cell(s_column,0);
        else            x_level = mat2cell(cell2mat(scan.running.model(i_model).level.value),s_column,ones(1,s_subname));
        end
        
        % columns
        j_column = 0;
        for i_subject = 1:scan.running.subject.number
            ii_subject = (x_column.subject == i_subject);
            for i_session = 1:scan.running.subject.session(i_subject)
                ii_session = (x_column.session == i_session);
                for i_condition = 1:length(scan.job.glm.condition)
                    ii_condition = strcmp(x_column.name,scan.job.glm.condition{i_condition});
                    f_column = find(ii_subject & ii_session & ii_condition);
                    for i_column = 1:length(f_column)
                        j_column = j_column + 1;
                        scan.running.model(i_model).column(j_column).subject = x_column.subject(f_column(i_column));
                        scan.running.model(i_model).column(j_column).session = x_column.session(f_column(i_column));
                        scan.running.model(i_model).column(j_column).order   = x_column.order(f_column(i_column));
                        scan.running.model(i_model).column(j_column).name    = x_column.name{f_column(i_column)};
                        scan.running.model(i_model).column(j_column).onset   = x_column.onset(f_column(i_column));
                        scan.running.model(i_model).column(j_column).level   = pair2struct(mat2vec([x_subname;num2cell(cellfun(@(x)x(f_column(i_column)),x_level))]));
                    end
                end
            end
        end
    end
end
