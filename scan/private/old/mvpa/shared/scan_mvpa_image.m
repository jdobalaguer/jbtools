
function scan = scan_mvpa_image(scan)
    %% scan = SCAN_MVPA_IMAGE(scan)
    % load images
    % see also scan_mvpa_dx
    %          scan_mvpa_rsa
    
    %% WARNINGS
    %#ok<*AGROW>
    
    %% FUNCTION
    n_image = length(scan.mvpa.image);
    
    % assert
    assert(scan.subject.n == length(scan.mvpa.variable.file), 'scan_mvpa_image: error. number of subjects doesnt match');
    
    % load images
    for i_subject = 1:scan.subject.n
        for i_image = 1:n_image
            path = scan.mvpa.variable.file{i_subject,i_image};

            % subject
            subject = scan.subject.u(i_subject);
            image   = scan.mvpa.image{i_image};
            fprintf('scan_mvpa: loading subject %02i: image "%s": \n',subject,image);

            % get size
            [~,scan.mvpa.variable.size{i_subject}] = scan_nifti_load(path{1});

            % numbers
            n_voxel = prod(scan.mvpa.variable.size{i_subject});
            n_beta  = length(path);

            % load images
            beta = nan(n_voxel,n_beta);
            jb_parallel_progress(n_beta);
            for i_beta = 1:n_beta
                [v,s] = scan_nifti_load(path{i_beta});
                if isempty(scan.mvpa.variable.size{i_subject}), scan.mvpa.variable.size{i_subject} = s; end
                assert(all(s==scan.mvpa.variable.size{i_subject}),'scan_mvpa_image: error. inconsistent image %02i',i_beta);
                beta(:,i_beta) = v;
                jb_parallel_progress();
            end
            jb_parallel_progress(0);

            % assert
            if isequaln(beta , single(beta))
                beta = single(beta);
            else
                warning('scan_mvpa_image: warning. cannot convert to single');
            end
            
            % save
            scan.mvpa.variable.beta{i_subject,i_image} = beta;
        end
    end
    
    % save
    scan.mvpa.variable.subject = scan.subject;
end