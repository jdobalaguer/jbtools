
function scan = scan_preprocess_slicetime(scan)
    %% scan = SCAN_PREPROCESS_SLICETIME(scan)
    % slice-time correction
    % to list main functions, try
    %   >> help scan;

    %% function
    if ~scan.running.flag.slicetime, return; end
    
    % print
    scan_tool_print(scan,false,'\nSlice-time correction : ');
    scan_tool_progress(scan,sum(scan.running.subject.session));
    
    % concatenate files
    for i_subject = 1:scan.running.subject.number
        for i_session = 1:scan.running.subject.session(i_subject)
            scan_tool_progress(scan,[]);
        end
    end
    scan_tool_progress(scan,0);
end
