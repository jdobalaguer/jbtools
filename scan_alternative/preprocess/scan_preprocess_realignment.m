
function scan = scan_preprocess_realignment(scan)
    %% scan = SCAN_PREPROCESS_REALIGNMENT(scan)
    % realign EPI images
    % to list main functions, try
    %   >> help scan;

    %% function
    if ~scan.running.flag.realignment, return; end
    
    % print
    scan_tool_print(scan,false,'\nRealignment : ');
    scan_tool_progress(scan,sum(scan.running.subject.session));
    
    % concatenate files
    for i_subject = 1:scan.running.subject.number
        for i_session = 1:scan.running.subject.session(i_subject)
            scan_tool_progress(scan,[]);
        end
    end
    scan_tool_progress(scan,0);
end
