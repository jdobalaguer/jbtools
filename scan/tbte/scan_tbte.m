
function scan = scan_tbte(scan)
    %% scan = SCAN_TBTE(scan)
    % runs trial-by-trial estimates (TBTE)
    % to list main functions, try
    %   >> help scan;

    %% function
    
    % job type
    scan.job.type = 'tbte';
    
    % summary
    scan_tool_summary(scan,'Trial-by-trial estimates (TBTE)',...
        'Initialize',...
        ...
        'First steps',...
        ...
        'Check condition',...
        'Add regressor',...
        'Filter regressor',...
        'SPM Design',...
        'Set matrix',...
        ...
        'SPM Estimation',...
        'Copy beta (first level)',...
        'Copy SPM mat-file (first level)',...
        ...
        'Add function');
    
    % initialize
    scan = scan_assert_spm(scan);               % assert (spm)
    scan = scan_initialize(scan);               % initialize scan / SPM
    try
        % first steps
        scan = scan_tbte_steps(scan);
        
        % design
        scan = scan_glm_condition_check(scan);  % check
        scan = scan_tbte_condition_split(scan); % split
        scan = scan_glm_regressor_add(scan);    % add
        scan = scan_glm_regressor_filter(scan); % filter
        scan = scan_glm_regressor_zscore(scan); % zscore
        scan = scan_glm_remove(scan);           % remove first volumes
        scan = scan_glm_design(scan);           % SPM design
        scan = scan_glm_matrix(scan);           % set matrix

        % estimation
        scan = scan_glm_estimation(scan);       % SPM estimation
        scan = scan_glm_copy(scan,'first','mask',0); % copy
        scan = scan_glm_copy(scan,'first','beta',0); % copy
        scan = scan_glm_copy(scan,'first','spm', 0); % copy
        
        % function
        scan = scan_tbte_function(scan);
        
        % save
        scan_save(scan);
        scan = scan_tool_time(scan);
        scan = scan_tool_sound(scan,1);
    catch e
        scan = scan_tool_catch(scan,e);
        scan = scan_tool_sound(scan,0);
    end
end
