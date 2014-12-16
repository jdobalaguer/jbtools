
function scan = scan_mvpa_searchlight_normalize(scan)
    %% scan = SCAN_MVPA_SEARCHLIGHT_NORMALIZE(scan)
    % normalize searchligh dmaps
    % see also scan_mvpa_dx_searchlight
    % see also scan_mvpa_rsa_searchlight
    
    %% WARNINGS
    %#ok<*AGROW>
    
    %% FUNCTION
    
    % load template
    if scan.mvpa.mni
        template = sprintf('%s/data/nii/sub_%02i/epi3/run1/realignment/*mean*.nii',pwd(),scan.subject.u(1));
        template = dir(template);
        template = sprintf('%s/data/nii/sub_%02i/epi3/run1/realignment/%s',pwd(),scan.subject.u(1),template.name);
    else
        template = sprintf('%s/data/nii/sub_%02i/epi3/run1/normalisation%d/*mean*.nii',pwd(),scan.subject.u(1),scan.pars.voxs);
        template = dir(template);
        template = sprintf('%s/data/nii/sub_%02i/epi3/run1/normalisation%d/%s',pwd(),scan.subject.u(1),scan.pars.voxs,template.name);
    end
    
    % save d-maps into files
    for i_regressor = 1:length(scan.mvpa.regressor.name)
        for i_subject = 1:scan.subject.n
            path = [scan.dire.mvpa.map,sprintf('sub_%02i/final/',scan.subject.u(i_subject))];
            mkdirp(path);
            d_map = scan.mvpa.variable.result.dmap{i_subject}{i_regressor};
            scan_nifti_save(sprintf('%sdmap_crispy_%s.img',path,scan.mvpa.regressor.name{i_regressor}),d_map,template);
        end
    end
    
    % return if already normalization
    if ~scan.mvpa.mni, return; end
    
    % transform to MNI space
    tmp = parameters();
    tmp.subject.u = scan.subject.u;
    
    tmp.preprocess{1}.job  = 'normalisation_epi';
    tmp.preprocess{1}.from.path = [scan.dire.mvpa.map,'sub_%02i/final/'];
    tmp.preprocess{1}.from.file = 'dmap*.img';
    tmp.preprocess{1}.norm.path = [pwd(),'/data/nii/sub_%02i/str/normalisation',sprintf('%d',scan.pars.voxs)];
    tmp.preprocess{1}.norm.file = '*images*sn.mat';
    tmp.preprocess{1}.move.path = [scan.dire.mvpa.map,'sub_%02i/normalisation/'];
    tmp.preprocess{1}.move.file = {'wdmap*'};
    tmp.preprocess{1}.run = ones(size(scan.mvpa.regressor.session));

    tmp.preprocess{2}.job  = 'none';
    tmp.preprocess{2}.from.path = [scan.dire.mvpa.map,'sub_%02i/final/'];
    tmp.preprocess{2}.from.file = '';
    tmp.preprocess{2}.move.path = [scan.dire.mvpa.map,'sub_%02i/realignment/'];
    tmp.preprocess{2}.move.file = {'*'};
    tmp.preprocess{2}.run = ones(size(scan.mvpa.regressor.session));
    
    tmp.preprocess{3}.job  = 'normalisation_epi';
    tmp.preprocess{3}.from.path = [scan.dire.mvpa.mask,'sub_%02i/realignment/'];
    tmp.preprocess{3}.from.file = '*mask.img';
    tmp.preprocess{3}.norm.path = [pwd(),'/data/nii/sub_%02i/str/normalisation',sprintf('%d',scan.pars.voxs)];
    tmp.preprocess{3}.norm.file = '*images*sn.mat';
    tmp.preprocess{3}.move.path = [scan.dire.mvpa.mask,'sub_%02i/renormalisation/'];
    tmp.preprocess{3}.move.file = {'ww*mask*'};
    tmp.preprocess{3}.run = ones(size(scan.mvpa.regressor.session));
    
    tmp = scan_initialize(tmp);
    scan_preprocess_run(tmp);
    clear tmp;
    
    % copy back to sub_%02i folder
    for i_regressor = 1:length(scan.mvpa.regressor.name)
        for i_subject = 1:scan.subject.n
            path_from = [scan.dire.mvpa.map,sprintf('sub_%02i/normalisation/',scan.subject.u(i_subject))];
            path_to   = [scan.dire.mvpa.map,sprintf('sub_%02i/final/',scan.subject.u(i_subject))];
            file_from = sprintf('%swdmap_crispy_%s.img',path_from,scan.mvpa.regressor.name{i_regressor});
            file_to   = sprintf('%sdmap_crispy_%s.img', path_to,  scan.mvpa.regressor.name{i_regressor});
            copyfile(file_from,file_to);
            file_from = sprintf('%swdmap_crispy_%s.hdr',path_from,scan.mvpa.regressor.name{i_regressor});
            file_to   = sprintf('%sdmap_crispy_%s.hdr', path_to,  scan.mvpa.regressor.name{i_regressor});
            copyfile(file_from,file_to);
        end
    end
    
end
