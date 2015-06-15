
function scan = scan_rsa_comparison(scan)
    %% scan = SCAN_RSA_COMPARISON(scan)
    % enable searchlight
    % to list main functions, try
    %   >> help scan;
    
    %% function
    if ~scan.running.flag.searchlight, return; end
    if ~scan.job.searchlight,          return; end
    
    % print
    scan_tool_print(scan,false,'\nCompare model : ');
    scan_tool_progress(scan,sum(scan.running.subject.session));
    
    % comparison
    for i_subject = 1:scan.running.subject.number
        for i_session = 1:scan.running.subject.session(i_subject)
            model = cell2mat(mat2vec({scan.running.model{i_subject}{i_session}.vector}));
            model = mat_zscore(model,2);
            for i_mask = 1:length(scan.running.mask)
                rdm = scan.running.rdm{i_subject}{i_session}(i_mask).vector;
                rdm = mat_zscore(rdm,2);
                scan.running.comparison{i_subject}{i_session}(i_mask).model = {scan.running.model{i_subject}{i_session}.model};
                scan.running.comparison{i_subject}{i_session}(i_mask).beta  = glmfit(model',rdm','normal','constant','off');
            end
            
            % wait
            scan_tool_progress(scan,[]);
        end
    end
    scan_tool_progress(scan,0);

end
