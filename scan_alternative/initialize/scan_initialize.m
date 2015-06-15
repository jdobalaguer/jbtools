
function scan = scan_initialize(scan)
    %% scan = SCAN_INITIALIZE(scan)
    % autocomplete the scan variable
    % to list main functions, try
    %   >> help scan;
    
    %% function
    
    % print
    scan_tool_print(scan,false,'\nInitialize : ');
    
    % initialize
    scan = scan_initialize_spm(scan);
    template = scan_initialize_template(scan.job.type);
    scan     = struct_default(scan,template);
    scan_tool_assert(scan,struct_cmp(scan,template),'some fields didnt match');
    scan     = scan_initialize_time(scan);
    scan     = scan_initialize_autocomplete(scan);
    
end
