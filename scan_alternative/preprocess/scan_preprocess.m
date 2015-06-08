
function scan = scan_preprocess(scan)
    %% scan = SCAN_PREPROCESS(scan)
    % Preprocessing pipeline
    % to list main functions, try
    %   >> help scan;

    %% function
    
    % job type
    scan.job.type = 'preprocess';
    scan.job.name = '';
    
    % summary
    scan_tool_summary(scan,'Preprocessing pipeline',...
        'Initialize',...
        ...
        'Slice-time correction',...
        'Realignment',...
        'Coregistration (structural to functional)',...
        'Normalisation (coregistered structural to MNI)',...
        'Normalisation (functional to MNI)',...
        'Smoothing',...
        ...
        'Add function (check)');
     
    try
        % initialize
        scan = scan_initialize(scan);                   % initialize scan / SPM
        scan = scan_autocomplete_nii(scan,'epi3:image'); % autocomplete (nii)
        scan = scan_autocomplete_nii(scan,'structural:image'); % autocomplete (nii)
        scan = scan_preprocess_flag(scan);              % redo flags
        scan = scan_preprocess_rmdir(scan);             % remove old directories
        scan = scan_preprocess_mkdir(scan);             % create new directories
        scan = scan_job_save_caller(scan);              % save caller

        % preprocessing
        scan = scan_preprocess_slicetime(scan);         % slice-time correction
        scan = scan_preprocess_realignment(scan);       % realignment
        scan = scan_preprocess_coregistration(scan);    % coregistration (structural to MNI)
        scan = scan_preprocess_normalisation_epi(scan); % normalisation (structural to MNI)
        scan = scan_preprocess_normalisation_mni(scan); % normalisation (functional to MNI)
        scan = scan_preprocess_smooth(scan);            % smoothing
        
        % function
        scan = scan_function_preprocess_check(scan);
        
        % save
        scan_job_save_scan(scan);
        
    catch e
        scan_tool_warning(scan,false,'Preprocessing not completed');
        cd(scan.directory.root);
        scan_job_save_scan(scan);
        scan_tool_warning(scan,false,e.message);
        scan.result.error = e;
    end
end
