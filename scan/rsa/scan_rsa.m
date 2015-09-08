
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
        'Load GLM conditions',...
        'Load metadata',...
        'Load mask',...
        'Load beta volumes',...
        'Global transformation',...
        'Build model',...
        ...
        'RSA estimation',...
        'RSA first',...
        'RSA second',...
        'Add function');
    
    % initialize
    scan = scan_assert_spm(scan);               % assert (spm)
    scan = scan_assert_rsa(scan);               % assert (rsa)
    scan = scan_initialize(scan);               % initialize scan / SPM
    try
        % first steps
        scan = scan_rsa_steps(scan);

        % load data & models
        scan = scan_rsa_load(scan);             % load conditions
        scan = scan_rsa_meta(scan);             % load meta
        scan = scan_rsa_mask(scan);             % load mask
        scan = scan_rsa_beta(scan);             % load betas
        scan = scan_rsa_global(scan);           % apply global transformations
        scan = scan_rsa_model(scan);            % build model
        scan = scan_rsa_concat(scan);           % concatenate sessions
        
        % estimation, first, second, function
        scan = scan_rsa_searchlight(scan);
        scan = scan_rsa_roi(scan);
        
        % save
        scan_save_scan(scan);
        scan = scan_tool_time(scan);
        scan = scan_tool_sound(scan,1);
    catch e
        scan = scan_tool_catch(scan,e);
        scan = scan_tool_sound(scan,0);
    end
end
