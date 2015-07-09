
function scan = scan_rsa_global(scan)
    %% scan = SCAN_RSA_GLOBAL(scan)
    % apply a global transformation to the betas
    % to list main functions, try
    %   >> help scan;
    
    %% function
    if scan_tool_isdone(scan), return; end
    if ~scan.running.flag.load, return; end
    
    % print
    scan_tool_print(scan,false,'\nGlobal transformation : ');
    scan_tool_progress(scan,1);
    
    % variables
    beta    = double(scan.running.load.beta);
    subject = double(scan.running.load.subject);
    session = double(scan.running.load.session);
    [~,~,name] = unique(scan.running.load.name);
    
    % global transformation
    switch scan.job.global
        case 'none'
        case 'session demean'
            beta = vec_demean(beta ,vec_rows(subject,session));
        case 'session zscore'
            beta = vec_zscore(beta ,vec_rows(subject,session));
        case 'name demean'
            beta = vec_demean(beta ,vec_rows(subject,name));
        case 'name zscore'
            beta = vec_zscore(beta ,vec_rows(subject,name));
        case 'all demean'
            beta = vec_demean(beta ,vec_rows(subject,session,name));
        case 'all zscore'
            beta = vec_zscore(beta ,vec_rows(subject,session,name));
    end
    
    % save
    scan.running.load.beta = beta;
    
    % wait
    scan_tool_progress(scan,0);
    
    % done
    scan = scan_tool_done(scan);
end
