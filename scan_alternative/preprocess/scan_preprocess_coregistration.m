
function scan = scan_preprocess_coregistration(scan)
    %% scan = SCAN_PREPROCESS_COREGISTRATION(scan)
    % coregister structural with the mean EPI
    % to list main functions, try
    %   >> help scan;

    %% function
    if ~scan.running.flag.coregistration, return; end
        
    % print
    scan_tool_print(scan,false,'\nCoregistration (structural to functional) : ');
    scan_tool_progress(scan,sum(scan.running.subject.session));
    
    % concatenate files
    for i_subject = 1:scan.running.subject.number
        for i_session = 1:scan.running.subject.session(i_subject)
            scan_tool_progress(scan,[]);
        end
    end
    scan_tool_progress(scan,0);
end
