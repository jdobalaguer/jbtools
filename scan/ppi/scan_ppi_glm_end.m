
function scan = scan_ppi_glm_end(scan)
    %% scan = SCAN_PPI_GLM_END(scan)
    % first and second level analyses of GLM (for a PPI analysis)
    % see also scan_initialize
    %          scan_ppi_run

    %% WARNINGS
    %#ok<>
    
    %% FUNCTION
    do_firstlevel  = scan.ppi.do.firstlevel;
    do_secondlevel = scan.ppi.do.secondlevel;
    
    % 3 = first level (contrast and statistics)
    if do_firstlevel,   scan = scan_glm_first_contrast(scan);   save_scan(); end    % FIRST LEVEL:  run contrasts and statistics
    
    % 4 = second level
    if do_secondlevel,  scan = scan_glm_second_copy(scan);      save_scan(); end    % SECOND LEVEL: copy files from first level
    if do_secondlevel,  scan = scan_glm_second_contrast(scan);  save_scan(); end    % SECOND LEVEL: run contrasts and statistics
   
    % copy
    glm_copy = false(6); if isfield(scan.glm,'copy'), glm_copy = scan.glm.copy; end
    if glm_copy(1),     scan = scan_glm_copy_beta1(scan);       save_scan(); end    % COPY:         beta      (first level)
    if glm_copy(2),     scan = scan_glm_copy_contrast1(scan);   save_scan(); end    % COPY:         contrast  (first level)
    if glm_copy(3),     scan = scan_glm_copy_statistic1(scan);  save_scan(); end    % COPY:         statistic (first level)
    if glm_copy(4),     scan = scan_glm_copy_beta2(scan);       save_scan(); end    % COPY:         beta      (second level)
    if glm_copy(5),     scan = scan_glm_copy_contrast2(scan);   save_scan(); end    % COPY:         contrast  (second level)
    if glm_copy(6),     scan = scan_glm_copy_statistic2(scan);  save_scan(); end    % COPY:         statistic (second level)
    
    %% NESTED
    function save_scan(), save([scan.dire.glm.root,'scan.mat'],'scan'); end
end
