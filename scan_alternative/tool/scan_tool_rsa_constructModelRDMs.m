
function models = scan_tool_rsa_constructModelRDMs(scan,i_subject,i_session)
    %% models = SCAN_TOOL_RSA_CONSTRUCTMODELRDMS(scan,i_subject,i_session)
    % RSA toolbox - constructModelRDMs
    % to list main functions, try
    %   >> help scan;
    
    %% function
    
    % variables
    colors = fig_color('hsv',length(scan.job.model));
    
    % models
    models = struct('name',{},'RDM',{},'color',{});
    for i_model = 1:numel(scan.job.model)
        models(i_model).name  = scan.job.model(i_model).name;
        models(i_model).RDM   = squareform(scan.running.model(i_model).rdm{i_subject}{i_session}.rdm);
        models(i_model).color = colors(i_model,:);
    end
end
