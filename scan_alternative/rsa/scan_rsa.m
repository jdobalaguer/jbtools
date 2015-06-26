
function scan = scan_rsa(scan)
    %% scan = SCAN_RSA(scan)
    % Representation Similarity Analysis (RSA) script
    % to list main functions, try
    %   >> help scan;
    
    %% note
    % 2. the models should be able to catch a cell instead of a scalar number
    % 7. filter RSA
    % 8. re-sort RDMs
    % 9. shrink RDMs

    %% function
    
    % job type
    scan.job.type = 'rsa';
    
    % summary
    scan_tool_summary(scan,'Representation Similarity Analysis (RSA)',...
        'Initialize',...
        ...
        'Load beta',...
        'Load metadata',...
        'Load mask',...
        'Build model',...
        ...
        'RSA estimation',...
        'RSA analysis (first level)',...
        'RSA analysis (second level)',...
        ...
        'Add function');
    
    % initialize
    scan = scan_assert_spm(scan);               % assert (spm)
    scan = scan_assert_rsa(scan);               % assert (rsa)
    scan = scan_initialize(scan);               % initialize scan / SPM
    try
        scan = scan_autocomplete_rsa(scan);     % autocomplete (rsa)
        scan = scan_autocomplete_mask(scan,scan.running.glm.job.image); % autocomplete (mask)
        scan = scan_rsa_flag(scan);             % redo flags
        scan = scan_rsa_rmdir(scan);            % delete old directories
        scan = scan_rsa_mkdir(scan);            % create new directories
        scan = scan_save_caller(scan);          % save caller

        % load data & models
        scan = scan_rsa_beta(scan);             % load beta
        scan = scan_rsa_meta(scan);             % load meta
        scan = scan_rsa_mask(scan);             % load mask
        scan = scan_rsa_model(scan);            % build model
        if scan.job.concatSessions, scan.running.subject.session(:) = 1; end
        
        % estimation
        scan = scan_rsa_estimation(scan);
        
        % analysis
        scan = scan_rsa_first(scan);
        scan = scan_rsa_second(scan);

        % function
        scan = scan_rsa_function(scan);
        
        % save
        scan_save_scan(scan);
        scan = scan_tool_time(scan);
    catch e
        scan = scan_tool_catch(scan,e);
    end
end
