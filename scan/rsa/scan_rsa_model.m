
function scan = scan_rsa_model(scan)
    %% scan = SCAN_RSA_MODEL(scan)
    % build model
    % to list main functions, try
    %   >> help scan;
    
    %% function
    if scan_tool_isdone(scan), return; end
    if ~scan.running.flag.model, return; end
    
    % print
    scan_tool_print(scan,false,'\nBuild model : ');
    
    % name
    scan = scan_rsa_model_name(scan);
    
    % build level
    scan = scan_rsa_model_level(scan);
    
    % build columns
    scan = scan_rsa_model_column(scan);
    
    % build rdm
    scan = scan_rsa_model_rdm(scan);
    
    % done
    scan = scan_tool_done(scan);
end
