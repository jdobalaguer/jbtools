
function scan = scan_rsa_function(scan)
    %% scan = SCAN_RSA_FUNCTION(scan)
    % define functions
    % to list main functions, try
    %   >> help scan;

    %% function
    if ~scan.running.flag.function, return; end
    
    % print
    scan_tool_print(scan,false,'\nAdd function : ');
    
    % warning
    scan_tool_warning(scan,false,'not implemented yet'); return;
    
    % function @folder.*
    scan = scan_function_glm_folder_cd(scan);           % change directory
    scan = scan_function_rsa_folder_manager(scan);      % folder manager
    
    % function @get.*
%     scan = scan_function_glm_get_vector(scan);          % vector
    
    % function @plot.*
    scan = scan_function_rsa_plot_rdm(scan); % plot rdm
    scan = scan_function_rsa_plot_model(scan); % plot model
    scan = scan_function_rsa_plot_comparison(scan); % plot comparison
end
