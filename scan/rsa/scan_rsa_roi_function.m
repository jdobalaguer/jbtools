
function scan = scan_rsa_roi_function(scan)
    %% scan = SCAN_RSA_ROI_FUNCTION(scan)
    % define functions (roi)
    % to list main functions, try
    %   >> help scan;

    %% function
    if scan_tool_isdone(scan), return; end
    if ~scan.running.flag.function, return; end
    
    % print
    scan_tool_print(scan,false,'\nAdd function : ');
    
    % function @folder.*
%     scan = scan_function_rsa_folder_cd(scan);           % change directory
%     scan = scan_function_rsa_folder_manager(scan);      % folder manager
    
    % function @get.*
    scan = scan_function_rsa_get_rdm(scan);
    scan = scan_function_rsa_get_model(scan);
    scan = scan_function_rsa_get_rdmModel(scan);
    scan = scan_function_rsa_get_allRdm(scan);
    scan = scan_function_rsa_get_allModel(scan);
    scan = scan_function_rsa_get_allRdmModel(scan);
    scan = scan_function_rsa_get_avgModel(scan);
    scan = scan_function_rsa_get_avgRdmModel(scan);
    
    % function @plot.*
    scan = scan_function_rsa_plot_rdm(scan);
    scan = scan_function_rsa_plot_model(scan);
    scan = scan_function_rsa_plot_rdmModel(scan);
    scan = scan_function_rsa_plot_avgModel(scan);
    scan = scan_function_rsa_plot_avgRdmModel(scan);
%     scan = scan_function_rsa_plot_comparison(scan); % plot comparison
    
    % done
    scan = scan_tool_done(scan);
end
