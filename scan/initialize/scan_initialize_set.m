
function scan = scan_initialize_set(scan)
    %% scan = SCAN_INITIALIZE_SET(scan)
    % set general struct
    % see also scan_initialize
    
    %% WARNING
    %#ok<*NBRAK,*FPARK>
    
    %% GLM (example)
    % scan.glm.name       = 'unnamed';  ... identifier
    % scan.glm.image      = 'smooth';   ... "image" "normalization" "smooth"
    % scan.glm.function   = 'hrf';      ... "hrf" "fir"
    % scan.glm.fir.ord    = 8;          ... order of FIR
    % scan.glm.fir.len    = 14;         ... time length of FIR
    % scan.glm.hrf.ord    = [0 0];      ... temporal derivative and sparsity
    % scan.glm.delay      = 0;          ... delay shift for onsets
    % scan.glm.marge      = 5;          ... marge between onsets and last scan
    % scan.glm.regressor  = struct('subject',{},'session',{},'onset',{},'discard',{},'name',{},'subname',{},'level',{});
    % scan.glm.contrast   = struct('name',{},'convec',{});
    
    % scan.glm.plot.mask  = '';         ... regression
    % scan.glm.plot.contrast  = '';     ...
    % scan.glm.plot.extension = 'img';  ...
    
    %% MVPA (example)
    % scan.mvpa.name      = 'unnamed';  ... identifier
    % scan.mvpa.mask      = '';         ... mask applied to the image
    % scan.mvpa.partition = 4;          ... number of partitions for cross-validation (>1)
    % scan.mvpa.shift     = 0;          ... shift for regressors (aiming for the HRF peak, when not convolved)
    % scan.mvpa.nn.hidden = 50;         ... hidden neurons for the nn-classifier

    %% DIRECTORIES
    scan.dire.root                       = pwd();
    scan.dire.spm                        = [fileparts(which('spm.m')),filesep];
    scan.dire.mask                       = [scan.dire.root,filesep,'data',filesep,'mask',filesep];
    
    % nifti
    scan.dire.nii                        = struct();
    scan.dire.nii.root                   = [scan.dire.root,filesep,'data',filesep,'nii',filesep];
    scan.dire.nii.subs                   = dir([scan.dire.nii.root,'sub_*']); scan.dire.nii.subs = strcat(scan.dire.nii.root,strvcat(scan.dire.nii.subs.name),'/');
    scan.dire.nii.epi4                   = strcat(scan.dire.nii.subs,'epi4',filesep);
    scan.dire.nii.epi3                   = strcat(scan.dire.nii.subs,'epi3',filesep);
    scan.dire.nii.str                    = strcat(scan.dire.nii.subs,'str',filesep);
    
    % glm
    if isfield(scan,'glm')
        scan.dire.glm               = struct();
        scan.dire.glm.root          = [scan.dire.root,filesep,'data',filesep,'glm',filesep,scan.glm.name,filesep];
        scan.dire.glm.regressor     = [scan.dire.glm.root,'original',filesep,'regressor',filesep];
        scan.dire.glm.firstlevel    = [scan.dire.glm.root,'original',filesep,'first_level',filesep];
        scan.dire.glm.secondlevel   = [scan.dire.glm.root,'original',filesep,'second_level',filesep];
        scan.dire.glm.beta1         = [scan.dire.glm.root,'copy',filesep,'beta_1',filesep];
        scan.dire.glm.beta2         = [scan.dire.glm.root,'copy',filesep,'beta_2',filesep];
        scan.dire.glm.contrast1     = [scan.dire.glm.root,'copy',filesep,'contrast_1',filesep];
        scan.dire.glm.contrast2     = [scan.dire.glm.root,'copy',filesep,'contrast_2',filesep];
        scan.dire.glm.statistic1    = [scan.dire.glm.root,'copy',filesep,'statistic_1',filesep];
        scan.dire.glm.statistic2    = [scan.dire.glm.root,'copy',filesep,'statistic_2',filesep];
    end
    
    % mvpa
    if isfield(scan,'mvpa')
        scan.dire.mvpa              = struct();
        scan.dire.mvpa.root         = [scan.dire.root,filesep,'data',filesep,'mvpa',filesep,scan.mvpa.name,filesep];
    end
    
    %% FILES
    
    % mask
    if isfield(scan,'mvpa')
        if isempty(scan.mvpa.mask), scan.file.mvpa_mask = '';
        else                        scan.file.mvpa_mask = [scan.dire.mask,scan.mvpa.mask,'.img,1']; end
    end
    
    % T1
    scan.file.T1 = [scan.dire.spm,'templates/T1.nii,1'];
    
    %% SUBJECT
    if ~isfield(scan,'subject'), scan.subject = struct(); end
    assert(~isfield(scan.subject,'u') || ~isfield(scan.subject,'r'), 'scan_parameters: error. only one of subject.u and subject.r must be specified');
    if ~isfield(scan.subject,'u') && ~isfield(scan.subject,'r'), scan.subject.r = []; end
    if ~isfield(scan.subject,'u'),
        scan.subject.u   = 1:size(scan.dire.nii.subs, 1);
        scan.subject.u(jb_anyof(scan.subject.u,scan.subject.r)) = [];
        scan.subject     = rmfield(scan.subject,'r');
    end
    scan.subject.n   = length(scan.subject.u);
    
    %% SORT
    scan = struct_sort(scan);
end