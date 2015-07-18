
function scan = scan_glm(scan)
    %% scan = SCAN_GLM(scan)
    % General Linear Model (GLM) script
    % to list main functions, try
    %   >> help scan;

    %% function
    
    % job type
    scan.job.type = 'glm';
    
    % summary
    scan_tool_summary(scan,'General Linear Model (GLM)',...
        'Initialize',...
        ...
        'First steps',...
        ...
        'Check condition',...
        'Add regressor',...
        'Filter regressor',...
        'Z-score regressor',...
        'Remove volumes',...
        'Concatenate session (condition)',...
        'Concatenate session (regressor)',...
        'Concatenate session (file)',...
        'Add PPI',...
        'SPM Design',...
        'Set matrix',...
        ...
        'SPM Estimation',...
        'Copy beta (first level)',...
        'Copy mask (first level)',...
        ...
        'Set contrast',...
        'SPM analysis (first level)',...
        'Copy contrast (first level)',...
        'Copy statistic (first level)',...
        'Copy SPM mat-file (first level)',...
        ...
        'Build folder',...
        'SPM analysis (second level)',...
        'Copy beta file (second level)',...
        'Copy contrast file (second level)',...
        'Copy statistic file (second level)',...
        'Copy SPM mat-file (second level)',...
        ...
        'Add function');
     
    % initialize
    scan = scan_assert_spm(scan);               % assert (spm)
    scan = scan_initialize(scan);               % initialize scan / SPM
    try
        % first steps
        scan = scan_glm_steps(scan);

        % design
        scan = scan_glm_condition_check(scan);  % check
        scan = scan_glm_regressor_add(scan);    % add
        scan = scan_glm_regressor_filter(scan); % filter
        scan = scan_glm_regressor_zscore(scan); % zscore
        scan = scan_glm_ppi(scan);              % ppi
        scan = scan_glm_remove(scan);           % remove first volumes
        scan = scan_glm_condition_concat(scan); % concatenate sessions
        scan = scan_glm_regressor_concat(scan); % concatenate sessions and add offset
        scan = scan_glm_concat(scan);           % concatenate sessions (extra: file & running.subject.session)
        scan = scan_glm_design(scan);           % SPM design
        scan = scan_glm_matrix(scan);           % set matrix

        % estimation
        scan = scan_glm_estimation(scan);               % SPM estimation
        scan = scan_glm_copy(scan,'first','beta');      % copy
        scan = scan_glm_copy(scan,'first','mask');      % copy

        % first level analysis
        scan = scan_glm_contrast(scan);                 % contrasts
        scan = scan_glm_firstlevel(scan);               % SPM first level analyses
        scan = scan_glm_copy(scan,'first','contrast');  % copy
        scan = scan_glm_copy(scan,'first','statistic'); % copy
        scan = scan_glm_copy(scan,'first','spm');       % copy

        % second level analysis
        scan = scan_glm_secondlevel(scan);              % SPM second level analyses
        scan = scan_glm_copy(scan,'second','beta');     % copy
        scan = scan_glm_copy(scan,'second','contrast'); % copy
        scan = scan_glm_copy(scan,'second','statistic'); % copy
        scan = scan_glm_copy(scan,'second','spm');      % copy

        % function
        scan = scan_glm_function(scan);
        
        % save
        scan_save_scan(scan);
        scan = scan_tool_time(scan);
    catch e
        scan = scan_tool_catch(scan,e);
    end
end