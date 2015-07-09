
function scan = scan_tbte_function(scan)
    %% scan = SCAN_TBTE_FUNCTION(scan)
    % define functions
    % to list main functions, try
    %   >> help scan;

    %% function
    if scan_tool_isdone(scan), return; end
    if ~scan.running.flag.function, return; end
    
    % print
    scan_tool_print(scan,false,'\nAdd function : ');
    
    % function @folder.*
    scan = scan_function_glm_folder_cd(scan);           % change directory
    scan = scan_function_glm_folder_manager(scan);      % folder manager
    
    % function @get.*
    scan = scan_function_tbte_get_vector(scan);         % vector
    scan = scan_function_glm_get_beta(scan);            % beta
    scan = scan_function_tbte_get_meshgrid(scan);       % meshgrid
    
    % function @plot.*
    scan = scan_function_glm_plot_design(scan);         % review design
    scan = scan_function_tbte_plot_meshgrid(scan);      % meshgrid
    
    % done
    scan = scan_tool_done(scan);
end
