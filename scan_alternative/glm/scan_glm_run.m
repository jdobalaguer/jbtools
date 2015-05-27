
function scan = scan_glm_run(scan)
    %% scan = SCAN_GLM_RUN(scan)
    % runs a General Linear Model (GLM)
    % to list main functions, try
    %   >> scan;

    %% function
    
    % job type
    scan.job.type = 'glm';
    
    % initialize
    scan = scan_initialize(scan);           % initialize scan
    scan = scan_job_save_caller(scan);      % save caller
    scan = scan_glm_flag(scan);             % redo flags
    scan = scan_glm_rmdir(scan);            % delete old directories
    scan = scan_glm_mkdir(scan);            % create new directories
    spm_jobman('initcfg');                  % SPM
    file_mkdir(scan.running.directory.job); % create folder
    scan = scan_job_save_scan(scan);        % save scan
    
    % regressors
    scan = scan_glm_regressor_build(scan); % build
%     if do_regressor,    scan = scan_glm_regressor_outer(scan);  save_scan(); end    % REGRESSOR:    outside covariate
%     if do_regressor,    scan = scan_glm_regressor_check(scan);  save_scan(); end    % REGRESSOR:    check
%     if do_regressor,    scan = scan_glm_regressor_merge(scan);  save_scan(); end    % REGRESSOR:    merge
%     if do_regressor,    scan = scan_glm_regressor_outKF(scan);   save_scan(); end   % REGRESSOR:    outside filtering
    
    % design
%     if do_regression,   scan = scan_glm_first_design(scan);     save_scan(); end    % REGRESSION:   design

    % estimation
%     if do_regression,   scan = scan_glm_first_estimate(scan);   save_scan(); end    % REGRESSION:   estimate
%     

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
