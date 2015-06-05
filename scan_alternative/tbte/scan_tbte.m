
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
        'Add function (cd)',...
        'Add function (design)',...
        'Add function (roi)');
    
    try
        % initialize
        scan = scan_initialize(scan);           % initialize scan / SPM
        scan = scan_autocomplete_nii(scan);     % autocomplete (nii)
        scan = scan_autocomplete_tbte(scan);    % autocomplete (tbte)
        scan = scan_tbte_flag(scan);            % redo flags
        scan = scan_tbte_rmdir(scan);           % delete old directories
        scan = scan_tbte_mkdir(scan);           % create new directories
        scan = scan_job_save_caller(scan);      % save caller

        % design
        scan = scan_glm_condition_check(scan);  % check
        scan = scan_tbte_condition_split(scan); % split
        scan = scan_glm_regressor_add(scan);    % add
        scan = scan_glm_regressor_filter(scan); % filter
        scan = scan_glm_design(scan);           % SPM design
        scan = scan_glm_matrix(scan);           % set matrix

        % estimation
        scan = scan_glm_estimation(scan);       % SPM estimation
        scan = scan_glm_copy(scan,'first','beta'); % copy
        scan = scan_glm_copy(scan,'first','spm'); % copy

        % function
        scan = scan_function_glm_cd(scan);      % change directory
        scan = scan_function_glm_design(scan);  % review design
        scan = scan_function_glm_roi(scan);     % region of interest

        % result
        scan = rmfield(scan,'result');          % remove field

        % save
        scan_job_save_scan(scan);
        
    catch e
        scan_job_save_scan(scan);
        rethrow(e);
    end
end
