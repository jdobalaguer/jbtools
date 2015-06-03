
function scan = scan_initialize(scan)
    %% scan = SCAN_INITIALIZE(scan)
    % autocomplete the scan variable
    % to list main functions, try
    %   >> help scan;
    
    %% function
    scan = scan_initialize_spm(scan);
    template = scan_initialize_template(scan.job.type);
    scan     = struct_default(scan,template);
    scan     = scan_initialize_autocomplete(scan);
    
end