
function scan = scan_glm(scan)
    %% scan = SCAN_GLM(scan)
    % General Linear Model (GLM) script
    % to list main functions, try
    %   >> help scan;

    %% notes
    % check the multiple ways of using flags : second without first, first without second, pre-loading old scan...
    
    %% function
    
    % job type
    scan.job.type = 'glm';
    
    % summary
    scan_tool_summary(scan,'General Linear Model (GLM)',...
        'Check condition',...
        'Conatenate session (condition)',...
        'Add regressor',...
        'Conatenate session (regressor)',...
        'Filter regressor',...
        'Conatenate session (file)',...
        'SPM Design',...
        'Set matrix',...
        ...
        'SPM Estimation',...
        'Copy beta (first level)',...
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
        'Add function (cd)',...
        'Add function (xjview)',...
        'Add function (design)',...
        'Add function (roi)',...
        'Add function (fir)');
     
    try
        % initialize
        scan = scan_initialize(scan);           % initialize scan / SPM
        scan = scan_autocomplete_nii(scan);     % autocomplete (nii)
        scan = scan_autocomplete_glm(scan);     % autocomplete (glm)
        scan = scan_glm_flag(scan);             % redo flags
        scan = scan_glm_rmdir(scan);            % delete old directories
        scan = scan_glm_mkdir(scan);            % create new directories
        scan = scan_job_save_caller(scan);      % save caller

        % design
        scan = scan_glm_condition_check(scan);  % check
        scan = scan_glm_condition_concat(scan); % concatenate sessions
        scan = scan_glm_regressor_add(scan);    % add
        scan = scan_glm_regressor_concat(scan); % concatenate sessions and add offset
        scan = scan_glm_regressor_filter(scan); % filter
        scan = scan_glm_concat(scan);           % concatenate sessions (extra: file & running.subject.session)
        scan = scan_glm_design(scan);           % SPM design
        scan = scan_glm_matrix(scan);           % set matrix

        % estimation
        scan = scan_glm_estimation(scan);       % SPM estimation
        scan = scan_glm_copy(scan,'first','beta'); % copy

        % first level analysis
        scan = scan_glm_contrast(scan);         % contrasts
        scan = scan_glm_firstlevel(scan);       % SPM first level analyses
        scan = scan_glm_copy(scan,'first','contrast'); % copy
        scan = scan_glm_copy(scan,'first','statistic'); % copy
        scan = scan_glm_copy(scan,'first','spm'); % copy

        % second level analysis
        scan = scan_glm_secondlevel(scan);      % SPM second level analyses
        scan = scan_glm_copy(scan,'second','beta'); % copy
        scan = scan_glm_copy(scan,'second','contrast'); % copy
        scan = scan_glm_copy(scan,'second','statistic'); % copy
        scan = scan_glm_copy(scan,'second','spm'); % copy

        % function
        scan = scan_function_glm_cd(scan);      % change directory
        scan = scan_function_glm_xjview(scan);  % launch xjview
        scan = scan_function_glm_design(scan);  % review design
        scan = scan_function_glm_roi(scan);     % region of interest
        scan = scan_function_glm_fir(scan);     % finite impulse response
        
        % result
        scan = rmfield(scan,'result');          % remove field

        % save
        scan_job_save_scan(scan);
        
    catch e
        scan_job_save_scan(scan);
        rethrow(e);
    end
end
