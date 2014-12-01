
function scan = scan_mvpa_unnan(scan)
    %% scan = SCAN_MVPA_UNNAN(scan)
    % remove nan from images
    % see also scan_mvpa_run
    
    %% WARNINGS
    %#ok<*AGROW>
    
    %% FUNCTION
    
    % assert
    assert(scan.subject.n == length(scan.mvpa.variable.beta), 'scan_mvpa_unnan: error. number of subjects doesnt match');
    
    % remove nans
    for i_subject = 1:scan.subject.n
    
        % find nans
        ii_nan = any(isnan(scan.mvpa.variable.beta{i_subject}),2);
        
        % create mask (if didn't exist)
        if isempty(scan.mvpa.variable.mask{i_subject}),
            scan.mvpa.variable.mask{i_subject} = reshape(~ii_nan,scan.mvpa.variable.size{i_subject});
            
        % update mask (otherwise)
        else
            f_mask = find(scan.mvpa.variable.mask{i_subject}(:));
            scan.mvpa.variable.mask{i_subject}(f_mask(ii_nan)) = 0;
        end
        
        % update betas
        scan.mvpa.variable.beta{i_subject}(ii_nan,:) = [];
    end
end
