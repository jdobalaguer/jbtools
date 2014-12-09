
function scan = scan_mvpa_mni2sub(scan)
    %% scan = SCAN_MVPA_MNI2SUB(scan)
    % apply the inverse of normalization on masks, from MNI space to subject space
    % see also scan_mvpa_run
    %          scan_mvpa_run
    
    %% WARNINGS
    %#ok<*AGROW,*NASGU>
    
    %% FUNCTION
    if ~scan.mvpa.mni, return; end
    
    % assert
    assert(scan.subject.n == length(scan.mvpa.variable.mask), 'scan_mvpa_mni2sub: error. number of subjects doesnt match');
    
    % copy original mask
    for i_subject = 1:scan.subject.n
        subject = scan.subject.u(i_subject);
        fprintf('scan_mvpa: transform mask %02i: \n',subject);
        
        if isempty(scan.mvpa.mask{i_subject})
            error('scan_mvpa_mni2sub: error. TODO write empty mask');
        else
            [dire_from,name_from,ext_from] = fileparts(scan.mvpa.mask{i_subject});
            mask_from = [scan.dire.mask,dire_from,filesep,name_from];
            dire_norm = [scan.dire.mvpa.mask,'sub_%02i/normalisation/'];
            dire_real = [scan.dire.mvpa.mask,'sub_%02i/realignment/'];
            mask_norm = [sprintf(dire_norm,subject),'mask'];
            mkdirp(sprintf(dire_norm,subject));
            if exist([mask_from,'.nii'],'file'), copyfile([mask_from,'.nii'],[mask_norm,'.nii']); end
            if exist([mask_from,'.img'],'file'), copyfile([mask_from,'.img'],[mask_norm,'.img']); end
            if exist([mask_from,'.hdr'],'file'), copyfile([mask_from,'.hdr'],[mask_norm,'.hdr']); end
        end
    end
        
    % inverse normalization (MNI to functional)
    tmp = parameters();
    tmp.subject.u = scan.subject.u;
    tmp.preprocess{1}.job  = 'normalisation_mni';
    tmp.preprocess{1}.from.path = dire_norm;
    tmp.preprocess{1}.from.file = 'mask.img';
    tmp.preprocess{1}.norm.path = [pwd(),'/data/nii/sub_%02i/str/normalisation',sprintf('%d',tmp.pars.voxs)];
    tmp.preprocess{1}.norm.file = '*images*sn.mat';
    tmp.preprocess{1}.orig.path = [pwd(),'/data/nii/sub_%02i/epi3/run1/realignment'];
    tmp.preprocess{1}.orig.file = 'mean*images*.nii';
    tmp.preprocess{1}.move.path = dire_real;
    tmp.preprocess{1}.move.file = {};
    tmp.preprocess{1}.run = ones(1,max(scan.subject.u));
    tmp = scan_initialize(tmp);
    tmp = scan_preprocess_run(tmp);
    
    % load masks in subject space
    for i_subject = 1:scan.subject.n
        subject = scan.subject.u(i_subject);
        [m,s] = scan_nifti_load([sprintf(dire_real,subject),'wmask.img']);
        m(isnan(m(:))) = 0;
        m = round(m);
        scan.mvpa.variable.mask{i_subject} = m;
        scan.mvpa.variable.size{i_subject} = s;
    end
end