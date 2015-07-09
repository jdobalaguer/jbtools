
function scan = scan_rsa_steps(scan)
    %% scan = SCAN_RSA_STEPS(scan)
    % first steps
    % to list main functions, try
    %   >> help scan;

    %% function
    if scan_tool_isdone(scan), return; end
    
    % print
    scan_tool_print(scan,false,'\nFirst steps : ');
    scan_tool_progress(scan,6);
    
    % autocomplete (rsa)
    scan = scan_autocomplete_rsa(scan);
    scan_tool_progress(scan,[]);
    
    % autocomplete (mask)
    scan = scan_autocomplete_mask(scan,scan.running.glm.job.image);
    scan_tool_progress(scan,[]);
    
    % redo flags
    scan = scan_rsa_flag(scan);
    scan_tool_progress(scan,[]);
    
    % delete old directories
    scan = scan_rsa_rmdir(scan);
    scan_tool_progress(scan,[]);
	
    % create new directories
    scan = scan_rsa_mkdir(scan);
    scan_tool_progress(scan,[]);
    
    % save caller
    scan = scan_save_caller(scan,3);
    scan_tool_progress(scan,[]);
    
    % wait
    scan_tool_progress(scan,0);
    
    % done
    scan = scan_tool_done(scan);
end
