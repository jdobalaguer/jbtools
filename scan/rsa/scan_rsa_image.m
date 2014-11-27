
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
    path = scan.rsa.variable.file;
    mask = scan.rsa.variable.mask;
    for i_subject = 1:scan.subject.n
        subject = scan.subject.u(i_subject);
        fprintf('scan_rsa: loading subject %02i: \n',subject);
        
        % numbers
        n_beta  = length(path{i_subject});
        n_voxel = numel(scan_nifti_load(path{i_subject}{1},mask));
        
        % discarded images
        ii_subject = (scan.rsa.regressor.subject == subject);
        assert(sum(ii_subject)==n_beta, 'scan_rsa_image: error. number of subjects doesnt match');
        if isempty(scan.rsa.regressor.discard),
            ii_discard = false(size(ii_subject));
        else
            ii_discard = (scan.rsa.regressor.discard(ii_subject));
        end
        f_ndiscard = find(~ii_discard);
        n_ndiscard = length(f_ndiscard);
        
        % load images
        beta = nan(n_voxel,n_ndiscard);
        jb_parallel_progress(n_ndiscard);
        for i_beta = 1:n_ndiscard
            vol = scan_nifti_load(path{i_subject}{f_ndiscard(i_beta)},mask);
            beta(:,i_beta) = vol;
            jb_parallel_progress();
        end
        jb_parallel_progress(0);
        
        % save
        scan.rsa.variable.beta{i_subject} = beta;
    end
end