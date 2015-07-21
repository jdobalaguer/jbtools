
function scan = scan_preprocess_steps(scan)
    %% scan = SCAN_PREPROCESS_STEPS(scan)
    % first steps
    % to list main functions, try
    %   >> help scan;

    %% function
    if scan_tool_isdone(scan), return; end
    
    % print
    scan_tool_print(scan,false,'\nFirst steps : ');
    scan = scan_tool_progress(scan,5);
    
    % autocomplete (preprocess)
    scan = scan_autocomplete_preprocess(scan);
    scan = scan_tool_progress(scan,[]);
    
    % redo flags
    scan = scan_preprocess_flag(scan);
    scan = scan_tool_progress(scan,[]);
    
    % delete old directories
    scan = scan_preprocess_rmdir(scan);
    scan = scan_tool_progress(scan,[]);
	
    % create new directories
    scan = scan_preprocess_mkdir(scan);
    scan = scan_tool_progress(scan,[]);
    
    % save caller
    scan = scan_save_caller(scan,3);
    scan = scan_tool_progress(scan,[]);
    
    % wait
    scan = scan_tool_progress(scan,0);
    
    % done
    scan = scan_tool_done(scan);
end
