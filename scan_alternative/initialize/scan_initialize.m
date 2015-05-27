
function scan = scan_initialize(scan)
    %% scan = SCAN_INITIALIZE(scan)
    % autocomplete the scan variable
    % to list main functions, try
    %   >> scan;
    
    %% function
    template = scan_initialize_template(scan.job.type);
    scan     = struct_default(scan,template);
    scan     = scan_initialize_autocomplete(scan);
    
    switch scan.job.type
        case 'dicom'
        case 'glm'
            scan = scan_initialize_autocomplete_nii(scan);
            scan = scan_initialize_autocomplete_glm(scan);
        case 'tbte'
        case 'mvpa'
        case 'rsa'
        otherwise
            warning('scan_job_template: error. type "%s" unknown',scan.job.type);
    end
    
end