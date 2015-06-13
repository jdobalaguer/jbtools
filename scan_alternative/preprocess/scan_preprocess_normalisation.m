
function scan = scan_preprocess_normalisation(scan)
    %% scan = SCAN_PREPROCESS_NORMALISATION(scan)
    % apply normalisation, from mean EPI to MNI space
    % to list main functions, try
    %   >> help scan;

    %% function
    if ~scan.running.flag.normalisation, return; end
    
    % print
    scan_tool_print(scan,false,'\nNormalisation (functional to MNI) : ');
    scan_tool_progress(scan,sum(scan.running.subject.session));
    
    % last
    scan.running.last.epi3 = 'normalisation';
    
    % concatenate files
    for i_subject = 1:scan.running.subject.number
        for i_session = 1:scan.running.subject.session(i_subject)
            scan_tool_progress(scan,[]);
        end
    end
    scan_tool_progress(scan,0);
end
