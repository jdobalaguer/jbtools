
function scan = scan_preprocess_slicetime(scan)
    %% scan = SCAN_PREPROCESS_SLICETIME(scan)
    % slice-time correction
    % to list main functions, try
    %   >> help scan;

    %% function
    if scan_tool_isdone(scan), return; end
    if ~scan.running.flag.slicetime, return; end
    
    scan_tool_warning(scan,false,'not implemented yet'); return;
    
    % print
    scan_tool_print(scan,false,'\nSlice-time correction : ');
    
    % done
    scan = scan_tool_done(scan);
end
