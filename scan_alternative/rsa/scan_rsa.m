
function scan = scan_rsa(scan)
    %% scan = SCAN_RSA(scan)
    % Representation Similarity Analysis (RSA) script
    % to list main functions, try
    %   >> help scan;
    
    %% function
    
    % job type
    scan.job.type = 'rsa';
    
    % summary
    scan_tool_summary(scan,'Representation Similarity Analysis (RSA)',...
        'Initialize',...
        ...
        'First steps',...
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
        % first steps
        scan = scan_rsa_steps(scan);

        % load data & models
        scan = scan_rsa_beta(scan);             % load beta
        scan = scan_rsa_meta(scan);             % load meta
        scan = scan_rsa_mask(scan);             % load mask
        scan = scan_rsa_model(scan);            % build model
        scan = scan_rsa_concat(scan);           % concatenate sessions
        
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
