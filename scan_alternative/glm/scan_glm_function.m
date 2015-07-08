
function scan = scan_glm_function(scan)
    %% scan = SCAN_GLM_FUNCTION(scan)
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
    scan = scan_function_glm_folder_xjview(scan);       % launch xjview
    scan = scan_function_glm_folder_saveregressor(scan); % save regressor
    scan = scan_function_glm_folder_manager(scan);      % folder manager
    
    % function @get.*
    scan = scan_function_glm_get_roi(scan);             % region of interest
    scan = scan_function_glm_get_fir(scan);             % finite impulse response
    scan = scan_function_glm_get_vector(scan);          % vector
    scan = scan_function_glm_get_beta(scan);            % beta
    
    % function @plot.*
    scan = scan_function_glm_plot_design(scan);         % review design
    scan = scan_function_glm_plot_fir(scan);            % finite impulse response
    
    % done
    scan = scan_tool_done(scan);
end
