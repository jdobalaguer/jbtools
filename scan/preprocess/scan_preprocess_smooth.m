
function scan = scan_preprocess_smooth(scan)
    %% scan = SCAN_PREPROCESS_SMOOTH(scan)
    % smoothing
    % to list main functions, try
    %   >> help scan;

    %% function
    if scan_tool_isdone(scan), return; end
    if ~scan.running.flag.smooth, return; end
    
    % last
    scan.running.last.epi3 = 'smooth';
    
    % print
    scan_tool_print(scan,false,'\nSmoothing : ');
    scan = scan_tool_progress(scan,sum(scan.running.subject.session));
    
    % concatenate files
    for i_subject = 1:scan.running.subject.number
        for i_session = 1:scan.running.subject.session(i_subject)
            scan = scan_tool_progress(scan,[]);
        end
    end
    scan = scan_tool_progress(scan,0);
    
    % done
    scan = scan_tool_done(scan);
end
