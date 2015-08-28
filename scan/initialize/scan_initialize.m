
function scan = scan_initialize(scan)
    %% scan = SCAN_INITIALIZE(scan)
    % autocomplete the scan variable
    % to list main functions, try
    %   >> help scan;
    
    %% function
    if scan_tool_isdone(scan), return; end
    
    % initialize
    scan = scan_initialize_spm(scan);
    template = scan_initialize_template(scan.job.type);
    scan     = struct_default(scan,template);
    
    % print (if before, it would give a warning for [scan.running.file.progress])
    scan_tool_print(scan,false,'\nInitialize : ');
    scan = scan_tool_progress(scan,1);
    
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
function f = checkFields(s,t)
    u = strrep(fieldnames(struct_flat(s)),'_','.');
    b = cellfun(@(f)struct_isfield(t,f),u);
    f  = u(~b);
end