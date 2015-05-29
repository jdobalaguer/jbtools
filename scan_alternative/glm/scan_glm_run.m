
function scan = scan_glm_run(scan)
    %% scan = SCAN_GLM_RUN(scan)
    % runs a General Linear Model (GLM)
    % to list main functions, try
    %   >> help scan;

    %% function
    
    % job type
    scan.job.type = 'glm';
    
    % initialize
    scan = scan_initialize(scan);           % initialize scan / SPM
    scan = scan_job_save_caller(scan);      % save caller
    scan = scan_glm_flag(scan);             % redo flags
    scan = scan_glm_rmdir(scan);            % delete old directories
    scan = scan_glm_mkdir(scan);            % create new directories
    scan = scan_job_save_scan(scan);        % save scan
    
    % design
    scan = scan_glm_condition_check(scan);  % check
    scan = scan_glm_condition_concat(scan); % concatenate sessions (condition)
    scan = scan_glm_regressor_add(scan);    % add
    scan = scan_glm_regressor_concat(scan); % concatenate sessions and add offset
    scan = scan_glm_regressor_filter(scan); % filter
    scan = scan_glm_concat(scan);           % concatenate sessions (extra: file & running.subject.session)
    scan = scan_glm_design(scan);           % SPM design

    % estimation
    scan = scan_glm_estimation(scan);       % SPM estimation
    
    % first level contrast and first level statistic
%                         scan = scan_glm_setcontrasts(scan);     save_scan();        % FIRST LEVEL:  set contrasts
%     if do_firstlevel,   scan = scan_glm_first_contrast(scan);   save_scan(); end    % FIRST LEVEL:  run contrasts and statistics
%     
    % second level statistic
%     if do_secondlevel,  scan = scan_glm_second_copy(scan);      save_scan(); end    % SECOND LEVEL: copy files from first level
%     if do_secondlevel,  scan = scan_glm_second_contrast(scan);  save_scan(); end    % SECOND LEVEL: run contrasts and statistics
%    
%     % copy
%     glm_copy = false(6); if isfield(scan.glm,'copy'), glm_copy = scan.glm.copy; end
%     if glm_copy(1),     scan = scan_glm_copy_beta1(scan);       save_scan(); end    % COPY:         beta      (first level)
%     if glm_copy(2),     scan = scan_glm_copy_contrast1(scan);   save_scan(); end    % COPY:         contrast  (first level)
%     if glm_copy(3),     scan = scan_glm_copy_statistic1(scan);  save_scan(); end    % COPY:         statistic (first level)
%     if glm_copy(4),     scan = scan_glm_copy_beta2(scan);       save_scan(); end    % COPY:         beta      (second level)
%     if glm_copy(5),     scan = scan_glm_copy_contrast2(scan);   save_scan(); end    % COPY:         contrast  (second level)
%     if glm_copy(6),     scan = scan_glm_copy_statistic2(scan);  save_scan(); end    % COPY:         statistic (second level)
end
