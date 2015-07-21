
function scan = scan_conversion_steps(scan)
    %% scan = SCAN_CONVERSION_STEPS(scan)
    % first steps
    % to list main functions, try
    %   >> help scan;

    %% function
    if scan_tool_isdone(scan), return; end
    
    % print
    scan_tool_print(scan,false,'\nFirst steps : ');
    scan = scan_tool_progress(scan,7);
    
    % autocomplete (dicom)
    scan = scan_autocomplete_dicom(scan);
    scan = scan_tool_progress(scan,[]);
    
    % autocomplete (nii)
    scan = scan_autocomplete_nii(scan,'structural:image');
    scan = scan_tool_progress(scan,[]);
    
    % autocomplete (nii)
    scan = scan_autocomplete_nii(scan,'epi4');
    scan = scan_tool_progress(scan,[]);
    
    % autocomplete (nii)
    scan = scan_autocomplete_nii(scan,'epi3:image');
    scan = scan_tool_progress(scan,[]);
    
    % redo flags
    scan = scan_conversion_flag(scan);
    scan = scan_tool_progress(scan,[]);
    
    % delete old directories
    scan = scan_conversion_rmdir(scan);
    scan = scan_tool_progress(scan,[]);
	
    % create new directories
    scan = scan_conversion_mkdir(scan);
    scan = scan_tool_progress(scan,[]);
    
    % wait
    scan = scan_tool_progress(scan,0);
    
    % done
    scan = scan_tool_done(scan);
end
