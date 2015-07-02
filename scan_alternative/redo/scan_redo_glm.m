
function scan = scan_redo_glm(scan,from)
    %% scan = SCAN_REDO_GLM(scan,from)
    % Keep running the GLM from where it was
    % to list main functions, try
    %   >> help scan;

    %% function
    
    % job type
    scan_tool_assert(scan,strcmp(scan.job.type,'glm'),'This scan doesn''t correspond to a GLM');
     
    % initialize
    try
        switch from
            case 'from estimation'
                scan = scan_glm_estimation(scan);               % SPM estimation
                scan = scan_glm_copy(scan,'first','beta');      % copy
                scan = scan_glm_copy(scan,'first','mask');      % copy
                scan = scan_glm_contrast(scan);                 % contrasts
                scan = scan_glm_firstlevel(scan);               % SPM first level analyses
                scan = scan_glm_copy(scan,'first','contrast');  % copy
                scan = scan_glm_copy(scan,'first','statistic'); % copy
                scan = scan_glm_copy(scan,'first','spm');       % copy
                scan = scan_glm_secondlevel(scan);              % SPM second level analyses
                scan = scan_glm_copy(scan,'second','beta');     % copy
                scan = scan_glm_copy(scan,'second','contrast'); % copy
                scan = scan_glm_copy(scan,'second','statistic'); % copy
                scan = scan_glm_copy(scan,'second','spm');      % copy
                scan = scan_glm_function(scan);
            case 'from first'
                scan = scan_glm_contrast(scan);                 % contrasts
                scan = scan_glm_firstlevel(scan);               % SPM first level analyses
                scan = scan_glm_copy(scan,'first','contrast');  % copy
                scan = scan_glm_copy(scan,'first','statistic'); % copy
                scan = scan_glm_copy(scan,'first','spm');       % copy
                scan = scan_glm_secondlevel(scan);              % SPM second level analyses
                scan = scan_glm_copy(scan,'second','beta');     % copy
                scan = scan_glm_copy(scan,'second','contrast'); % copy
                scan = scan_glm_copy(scan,'second','statistic'); % copy
                scan = scan_glm_copy(scan,'second','spm');      % copy
                scan = scan_glm_function(scan);
            case 'from second'
                scan = scan_glm_secondlevel(scan);              % SPM second level analyses
                scan = scan_glm_copy(scan,'second','beta');     % copy
                scan = scan_glm_copy(scan,'second','contrast'); % copy
                scan = scan_glm_copy(scan,'second','statistic'); % copy
                scan = scan_glm_copy(scan,'second','spm');      % copy
                scan = scan_glm_function(scan);
            case 'from function'
                scan = scan_glm_function(scan);
        end
        
        % save
        scan_save_scan(scan);
        scan = scan_tool_time(scan);
    catch e
        scan = scan_tool_catch(scan,e);
    end
end
