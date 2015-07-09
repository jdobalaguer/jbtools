
function scan = scan_mvpa_sdt(scan)
    %% scan = SCAN_MVPA_SDT(scan)
    % calculate signal detection theory (SDT) values
    % see also scan_initialize
    %          scan_glm_run
    %          scan_mvpa_glm
    %          scan_mvpa_rsa
    
    %% WARNINGS
    %#ok<>
    
    %% FUNCTION
    
    % SPM toolbox
    if ~exist('spm.m','file'), spm8_add_paths(); end
    
    % redo
    redo = true(1,3);
    if isfield(scan.mvpa,'redo'), redo(1:scan.mvpa.redo-1) = false; end
    do_regressor   = redo(1) || ~exist(scan.dire.glm.regressor ,'dir');
    do_image       = redo(2) || ~exist(scan.dire.glm.firstlevel,'dir');
    do_sdt         = redo(3) || ~exist(scan.dire.glm.firstlevel,'dir');
    
    % set regressors
    if do_regressor,
        scan = scan_mvpa_regressor(scan);       % set regressors
    end
    
    % load images
    if do_image,
        scan = scan_mvpa_filename(scan);        % get beta files
        scan = scan_mvpa_mask(scan);            % load mask
        scan = scan_mvpa_mni2sub(scan);         % reverse normalization for subject
        scan = scan_mvpa_image(scan);           % load images
        scan = scan_mvpa_unnan(scan);           % remove nans
    end
    
    % run SDT
    if do_sdt,
        n_subject   = scan.subject.n;
        n_regressor = length(scan.mvpa.regressor.name);
        n_voxel     = size(scan.mvpa.variable.beta{1},1);
        
        dvar = nan(n_subject,n_regressor,n_voxel);
        for i_subject = 1:scan.subject.n
            for i_regressor = 1:n_regressor
                x = scan.mvpa.variable.beta{i_subject}';
                y = scan.mvpa.variable.regressor{i_subject}{i_regressor}.level';
                [u_level,n_level] = numbers(y);
                e = [];
                n = [];
                for i_level = 1:n_level
                    ii = (y == u_level(i_level));
                    e(i_level,:) = var(x(ii,:));
                    n(i_level,:) = repmat(sum(ii),[1,n_voxel]);
                end
                e = sum(e .* n) ./ length(y);
                dvar(i_subject,i_regressor,:) = var(x) - e;
                mask(i_regressor,:)           = abs(meeze(dvar,1)) > 1;
            end
        end
        scan.mvpa.variable.result.sdt.dvar = dvar;
        scan.mvpa.variable.result.sdt.mask = mask;
    end
    
end
