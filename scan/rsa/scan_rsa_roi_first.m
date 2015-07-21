
function scan = scan_rsa_roi_first(scan)
    %% scan = SCAN_RSA_ROI_FIRST(scan)
    % RSA first-level analysis (roi)
    % to list main functions, try
    %   >> help scan;
    
    %% function
    if scan_tool_isdone(scan), return; end
    if ~scan.running.flag.first, return; end
    
    % print
    scan_tool_print(scan,false,'\nRSA analysis (first level) : ');
    scan = scan_tool_progress(scan,scan.running.subject.number);

    
    % first-level analysis
    scan.result.first = nan(scan.running.subject.number,numel(scan.job.model));
    for i_subject = 1:scan.running.subject.number

        % group volumes
        r = nan(scan.running.subject.session(i_subject),numel(scan.job.model));
        for i_session = 1:scan.running.subject.session(i_subject)
            r(i_session,:) = mat2vec(scan.result.zero{i_subject}{i_session}.r);
        end

        % save
        scan.result.first(i_subject,:) = nanmean(r,1);

        % wait
        scan = scan_tool_progress(scan,[]);
    end
    scan = scan_tool_progress(scan,0);
    
    % done
    scan = scan_tool_done(scan);
end
