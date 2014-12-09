
function scan = scan_mvpa_searchlight_do(scan,i_sphere)
    %% scan = SCAN_MVPA_SEARCHLIGHT_DO(scan,i_sphere)
    % set iteration for searchlight
    % see also scan_mvpa_dx_searchlight
    
    %% WARNINGS
    %#ok<*AGROW>
    
    %% FUNCTION
    
    % create spheres
    for i_subject = 1:scan.subject.n
        scan.mvpa.variable.beta{i_subject} = scan.mvpa.variable.searchlight.beta{i_subject};
        
        if scan.mvpa.variable.searchlight.n_sphere(i_subject) > i_sphere,
            
            % get
            mask = logical(scan.mvpa.variable.searchlight.mask{i_subject});
            s    = scan.mvpa.variable.size{i_subject};

            % create matrix with coordinates
            m_x = repmat(reshape(1:s(1),[1,s(1),1,1]),[1,1,s(2),s(3)]);
            m_y = repmat(reshape(1:s(2),[1,1,s(2),1]),[1,s(1),1,s(3)]);
            m_z = repmat(reshape(1:s(3),[1,1,1,s(3)]),[1,s(1),s(2),1]);
            m   = cat(1,m_x,m_y,m_z);
            clear m_x m_y m_z;
            
            % find matrix with voxel coordinates
            f_voxel  = find(mask(:));
            i_voxel = f_voxel(i_sphere);
            p = repmat(reshape(m(:,i_voxel),[3,1,1,1]),[1,s]);
            
            % create sphere
            d = (p - m);
            d = d.*d;
            radius = scan.mvpa.sphere * scan.mvpa.sphere;
            sphere = squeeze(sum(d,1)) < radius;
            assert(all(size(sphere) == s), 'scan_mvpa_searchlight_do: error. sphere size not consistent.');

            % save
            scan.mvpa.variable.mask{i_subject} = sphere;
        end
    end
    
end
