
function scan = scan_rsa_image(scan)
    %% scan = SCAN_RSA_IMAGE(scan)
    % load images (RSA)
    % see also scan_rsa_run
    
    %% WARNINGS
    %#ok<*AGROW>
    
    %% FUNCTION
    
    % assert
    assert(scan.subject.n == length(scan.rsa.variable.file), 'scan_rsa_image: error. number of subjects doesnt match');
    
    % load images
    for i_subject = 1:scan.subject.n
        path = scan.rsa.variable.file{i_subject};
        mask = scan.rsa.variable.mask{i_subject};
        
        % subject
        subject = scan.subject.u(i_subject);
        fprintf('scan_rsa: loading subject %02i: \n',subject);
        
        % numbers
        n_voxel = numel(scan_nifti_load(path{1},mask));
        
        % discarded images
        ii_discard = scan.rsa.variable.discard{i_subject};
        f_ndiscard = find(~ii_discard);
        n_ndiscard = length(f_ndiscard);
        
        % load images
        beta = nan(n_voxel,n_ndiscard);
        jb_parallel_progress(n_ndiscard);
        for i_beta = 1:n_ndiscard
            [v,s] = scan_nifti_load(path{f_ndiscard(i_beta)},mask);
            if isempty(scan.rsa.variable.size{i_subject}), scan.rsa.variable.size{i_subject} = s; end
            assert(all(s==scan.rsa.variable.size{i_subject}),'scan_rsa_image: error. inconsistent image %02i with mask size',i_beta);
            beta(:,i_beta) = v;
            jb_parallel_progress();
        end
        jb_parallel_progress(0);
        
        % save
        scan.rsa.variable.beta{i_subject} = beta;
    end
end