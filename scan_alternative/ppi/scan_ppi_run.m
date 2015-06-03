
function scan = scan_ppi_run(scan)
    %% scan = SCAN_PPI_RUN(scan)
    % runs a PsychoPhysical Interaction (PPI)
    % to list main functions, try
    %   >> help scan;

    %% function
    
    % job type
    scan.job.type = 'ppi';
    
    % summary
    scan_tool_summary(scan,'PsychoPhysical Interaction (PPI)',...
        'Check condition',...
        'Conatenate session (condition)',...
        'Add regressor',...
        'Conatenate session (regressor)',...
        'Filter regressor',...
        'Conatenate session (file)',...
        'SPM Design',...
        'Set matrix',...
        ...
        'Add psychophysical interactions',...
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
        'Copy SPM mat-file (second level)');
    
    % initialize
    scan = scan_initialize(scan);           % initialize scan / SPM
    scan = scan_autocomplete_nii(scan);     % autocomplete (nii)
    scan = scan_autocomplete_glm(scan);     % autocomplete (glm)
    scan = scan_autocomplete_ppi(scan);     % autocomplete (ppi)
    scan = scan_glm_flag(scan);             % redo flags
    scan = scan_glm_rmdir(scan);            % delete old directories
    scan = scan_glm_mkdir(scan);            % create new directories
    scan = scan_job_save_caller(scan);      % save caller
    scan_job_save_scan(scan);               % save scan
    
    % design
    scan = scan_glm_condition_check(scan);  % check
    scan = scan_glm_condition_concat(scan); % concatenate sessions
    scan = scan_glm_regressor_add(scan);    % add
    scan = scan_glm_regressor_concat(scan); % concatenate sessions and add offset
    scan = scan_glm_regressor_filter(scan); % filter
    scan = scan_glm_concat(scan);           % concatenate sessions (extra: file & running.subject.session)
    scan = scan_glm_design(scan);           % SPM design
    scan = scan_glm_matrix(scan);           % set matrix
    scan_job_save_scan(scan);               % save scan
    
    % psychophysical interaction
    scan = scan_ppi_add(scan);              % add
    scan = scan_glm_matrix(scan);           % set matrix (again)
    scan_job_save_scan(scan);               % save scan

    % estimation
    scan = scan_glm_estimation(scan);       % SPM estimation
    scan_job_save_scan(scan);               % save scan
    scan = scan_glm_copy(scan,'first','beta'); % copy
    
    % first level analysis
    scan = scan_glm_contrast(scan);         % contrasts
    scan = scan_glm_firstlevel(scan);       % first level analyses
    scan_job_save_scan(scan);               % save scan
    scan = scan_glm_copy(scan,'first','contrast'); % copy
    scan = scan_glm_copy(scan,'first','statistic'); % copy
    scan = scan_glm_copy(scan,'first','spm'); % copy
    
    % second level analysis
    scan = scan_glm_secondlevel(scan);      % second level analyses
    scan_job_save_scan(scan);               % save scan
    scan = scan_glm_copy(scan,'second','beta'); % copy
    scan = scan_glm_copy(scan,'second','contrast'); % copy
    scan = scan_glm_copy(scan,'second','statistic'); % copy
    scan = scan_glm_copy(scan,'second','spm'); % copy
    
    % result
    scan = rmfield(scan,'result');          % remove field
    
    % function
    % TO DO
end
