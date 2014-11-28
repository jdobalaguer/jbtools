
function scan = scan_rsa_unnan(scan)
    %% scan = SCAN_RSA_UNNAN(scan)
    % remove nan from images (RSA)
    % see also scan_rsa_run
    
    %% WARNINGS
    %#ok<*AGROW>
    
    %% FUNCTION
    
    % assert
    assert(scan.subject.n == length(scan.rsa.variable.beta), 'scan_rsa_unnan: error. number of subjects doesnt match');
    
    % remove nans
    for i_subject = 1:scan.subject.n
    
        % find nans
        ii_nan = any(isnan(scan.rsa.variable.beta{i_subject}),2);
        
        % create mask (if didn't exist)
        if isempty(scan.rsa.variable.mask{i_subject}),
            scan.rsa.variable.mask{i_subject} = reshape(~ii_nan,scan.rsa.variable.size{i_subject});
            
        % update mask (otherwise)
        else
            f_mask = find(scan.rsa.variable.mask{i_subject}(:));
            scan.rsa.variable.mask{i_subject}(f_mask(ii_nan)) = 0;
        end
        
        % update betas
        scan.rsa.variable.beta{i_subject}(ii_nan,:) = [];
    end
end
