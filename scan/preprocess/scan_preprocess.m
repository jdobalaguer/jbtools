
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
        'First steps',...
        ...
        'Slice-time correction',...
        'Realignment',...
        'Coregistration (structural to functional)',...
        'Segmentation',...
        'Estimation (of the normalisation from co-registered structural to MNI)',...
        'Normalisation (functional to MNI)',...
        'Smoothing');
     
    % initialize
    scan = scan_assert_spm(scan);                       % assert (spm)
    scan = scan_initialize(scan);                       % initialize scan / SPM
    try
        % first steps
        scan = scan_preprocess_steps(scan);

        % preprocessing
        scan = scan_preprocess_slicetime(scan);         % slice-time correction
        scan = scan_preprocess_realignment(scan);       % realignment
        scan = scan_preprocess_coregistration(scan);    % coregistration
        scan = scan_preprocess_segmentation(scan);      % segmentation
        scan = scan_preprocess_estimation(scan);        % normalisation (structural to MNI)
        scan = scan_preprocess_normalisation(scan);     % normalisation (functional to MNI)
        scan = scan_preprocess_smooth(scan);            % smoothing
        
        % save
        scan_save_scan(scan);
        scan = scan_tool_time(scan);
    catch e
        scan = scan_tool_catch(scan,e);
    end
end
