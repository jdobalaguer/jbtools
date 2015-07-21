
function scan = scan_initialize(scan)
    %% scan = SCAN_INITIALIZE(scan)
    % autocomplete the scan variable
    % to list main functions, try
    %   >> help scan;
    
    %% function
    if scan_tool_isdone(scan), return; end
    
    % print
    scan_tool_print(scan,false,'\nInitialize : ');
    scan = scan_tool_progress(scan,1);
    
    % initialize
    scan = scan_initialize_spm(scan);
    template = scan_initialize_template(scan.job.type);
    scan     = struct_default(scan,template);
    
    % check
    f = checkFields(scan,template);
    for i = 1:length(f), scan_tool_warning(scan,true,'field "%s" not found in template. it will be ignored.',f{i}); end
    
    % autocomplete
    scan     = scan_initialize_time(scan);
    scan     = scan_initialize_autocomplete(scan);
    
    % wait
    scan = scan_tool_progress(scan,0);
    
    % done
    scan = scan_tool_done(scan);
end

%% auxiliar
function f = checkFields(s1,s2)
    u1 = fieldnames(struct_flat(s1));
    u2 = fieldnames(struct_flat(s2));
    b  = ismember(u1,u2);
    f = strrep(u1(~b),'_','.');
end