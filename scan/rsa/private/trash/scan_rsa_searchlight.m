
function scan = scan_rsa_searchlight(scan)
    %% scan = SCAN_RSA_SEARCHLIGHT(scan)
    % enable searchlight
    % to list main functions, try
    %   >> help scan;
    
    %% function
    if isempty(scan.running.flag.searchlight), return; end
    if ~scan.job.searchlight,                  return; end
    
    scan_tool_warning(scan,false,'searchlight has not been implemented yet. this will be ignored');
    
    % print
    scan_tool_print(scan,false,'\nEnable searchlight : ');
    scan = scan_tool_progress(scan,sum(scan.running.subject.session));
    
    % searchlight
    for i_subject = 1:scan.running.subject.number
        for i_session = 1:scan.running.subject.session(i_subject)
            scan = scan_tool_progress(scan,[]);
        end
    end
    scan = scan_tool_progress(scan,0);

end
