
function scan = scan_preprocess_slicetime(scan)
    %% scan = SCAN_PREPROCESS_SLICETIME(scan)
    % slice-time correction
    % to list main functions, try
    %   >> help scan;

    %% function
    if ~scan.running.flag.slicetime, return; end
    
    scan_tool_warning(scan,false,'not implemented yet'); return;
    
    % print
    scan_tool_print(scan,false,'\nSlice-time correction : ');
end
