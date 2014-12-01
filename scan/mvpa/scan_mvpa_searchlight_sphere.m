
function scan = scan_mvpa_searchlight_sphere(scan)
    %% scan = SCAN_MVPA_SEARCHLIGHT_SPHERE(scan)
    % create sphere masks for the searchlight
    % see also scan_mvpa_searchlight
    
    %% WARNINGS
    %#ok<*AGROW>
    
    %% FUNCTION
    
    % assert
    assert(scan.subject.n == length(scan.mvpa.variable.file), 'scan_mvpa_searchlight_sphere: error. number of subjects doesnt match');
    
    % create spheres
    for i_subject = 1:scan.subject.n
        mask = scan.mvpa.variable.mask{i_subject};
        s    = scan.mvpa.variable.size{i_subject};
        
        % subject
        subject = scan.subject.u(i_subject);
        fprintf('scan_mvpa: creating spheres %02i: \n',subject);
        
        % numbers
        n_voxel  = numel(mask);
        n_sphere = sum(mask(:));
        
        % create matrix with coordinates
        m_x = repmat(reshape(1:s(1),[1,s(1),1,1]),[1,1,s(2),s(3)]);
        m_y = repmat(reshape(1:s(2),[1,1,s(2),1]),[1,s(1),1,s(3)]);
        m_z = repmat(reshape(1:s(3),[1,1,1,s(3)]),[1,s(1),s(2),1]);
        m   = cat(1,m_x,m_y,m_z);
        clear m_x m_y m_z;
        
        % create spheres
        u_sphere = false(n_sphere,n_voxel);
        f_voxel  = find(mask(:));
        radius   = scan.mvpa.sphere * scan.mvpa.sphere;
        jb_parallel_progress(n_sphere);
        for i_sphere = 1:n_sphere
            i_voxel = f_voxel(i_sphere);
            p = repmat(reshape(m(:,i_voxel),[3,1,1,1]),[1,s]);
            d = (p - m);
            d = d.*d;
            sphere = squeeze(sum(d)) < radius;
            u_sphere(i_sphere,:) = sphere(:);
            jb_parallel_progress();
        end
        jb_parallel_progress(0);
        
        % save
        scan.mvpa.variable.sphere{i_subject} = u_sphere;
    end
    
end
