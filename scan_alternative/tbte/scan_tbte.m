
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
    scan = scan_initialize(scan);               % initialize scan / SPM
    try
        scan = scan_autocomplete_nii(scan,['epi3:',scan.job.image]); % autocomplete (nii)
        scan = scan_autocomplete_nii(scan,'epi3:realignment'); % autocomplete (nii)
        scan = scan_autocomplete_tbte(scan);    % autocomplete (tbte)
        scan = scan_autocomplete_mask(scan,scan.job.image); % autocomplete (mask)
        scan = scan_tbte_flag(scan);            % redo flags
        scan = scan_tbte_rmdir(scan);           % delete old directories
        scan = scan_tbte_mkdir(scan);           % create new directories
        scan = scan_save_caller(scan);          % save caller

        % design
        scan = scan_glm_condition_check(scan);  % check
        scan = scan_tbte_condition_split(scan); % split
        scan = scan_glm_regressor_add(scan);    % add
        scan = scan_glm_regressor_filter(scan); % filter
        scan = scan_glm_regressor_zscore(scan); % zscore
        scan = scan_glm_design(scan);           % SPM design
        scan = scan_glm_matrix(scan);           % set matrix

        % estimation
        scan = scan_glm_estimation(scan);       % SPM estimation
        scan = scan_glm_copy(scan,'first','mask'); % copy
        scan = scan_glm_copy(scan,'first','beta'); % copy
        scan = scan_glm_copy(scan,'first','spm');  % copy
        
        % function
        scan = scan_tbte_function(scan);
        
        % save
        scan_save_scan(scan);
        scan = scan_tool_time(scan);
    catch e
        scan = scan_tool_catch(scan,e);
    end
end
