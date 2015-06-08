
function scan = scan_preprocess_normalisation_epi(scan)
    %% scan = SCAN_PREPROCESS_NORMALISATION_EPI(scan)
    % estimate normalisation parameters, from coregistered structural to MNI space
    % to list main functions, try
    %   >> help scan;

    %% function
    if ~scan.running.flag.estimation, return; end
    
    % print
    scan_tool_print(scan,false,'\nNormalisation (coregistered structural to MNI) : ');
    scan_tool_progress(scan,sum(scan.running.subject.session));
    
    % concatenate files
    for i_subject = 1:scan.running.subject.number
        for i_session = 1:scan.running.subject.session(i_subject)
            scan_tool_progress(scan,[]);
        end
    end
    scan_tool_progress(scan,0);
end
