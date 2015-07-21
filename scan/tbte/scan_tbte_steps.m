
function scan = scan_tbte_steps(scan)
    %% scan = SCAN_TBTE_STEPS(scan)
    % first steps
    % to list main functions, try
    %   >> help scan;

    %% function
    if scan_tool_isdone(scan), return; end
    
    % print
    scan_tool_print(scan,false,'\nFirst steps : ');
    scan = scan_tool_progress(scan,8);
    
    % autocomplete (nii)
    scan = scan_autocomplete_nii(scan,['epi3:',scan.job.image]);
    scan = scan_tool_progress(scan,[]);
    
    % autocomplete (nii)
    scan = scan_autocomplete_nii(scan,'epi3:realignment');
    scan = scan_tool_progress(scan,[]);
    
    % autocomplete (tbte)
    scan = scan_autocomplete_tbte(scan);
    scan = scan_tool_progress(scan,[]);
    
    % autocomplete (mask)
    scan = scan_autocomplete_mask(scan,scan.job.image);
    scan = scan_tool_progress(scan,[]);
    
    % redo flags
    scan = scan_tbte_flag(scan);
    scan = scan_tool_progress(scan,[]);
    
    % move old directories
    scan = scan_tool_movejob(scan);
    scan = scan_tool_progress(scan,[]);
	
    % create new directories
    scan = scan_tbte_mkdir(scan);
    scan = scan_tool_progress(scan,[]);
    
    % save caller
    scan = scan_save_caller(scan,3);
    scan = scan_tool_progress(scan,[]);
    
    % wait
    scan = scan_tool_progress(scan,0);
    
    % done
    scan = scan_tool_done(scan);
end
