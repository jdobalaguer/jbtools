
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
        x_level = mat2cell(cell2mat(scan.running.model(i_model).level.value),s_column,ones(1,s_subname));
        
        % columns
        for i_column = 1:s_column
            scan.running.model(i_model).column(i_column).subject = x_column.subject(i_column);
            scan.running.model(i_model).column(i_column).session = x_column.session(i_column);
            scan.running.model(i_model).column(i_column).name    = x_column.name{i_column};
            scan.running.model(i_model).column(i_column).onset   = x_column.onset(i_column);
            scan.running.model(i_model).column(i_column).level   = pair2struct(mat2vec([x_subname;num2cell(cellfun(@(x)x(i_column),x_level))]));
        end
    end
end
