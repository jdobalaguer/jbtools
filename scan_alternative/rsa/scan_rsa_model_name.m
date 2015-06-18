
function scan = scan_rsa_model_name(scan)
    %% scan = SCAN_RSA_MODEL_NAME(scan)
    % add names for the model
    % to list main functions, try
    %   >> help scan;
    
    %% function
    if ~scan.running.flag.model, return; end
    
    % name
    for i_model = 1:length(scan.job.model)
        scan.running.model(i_model).name = scan.job.model(i_model).name;
    end
end
