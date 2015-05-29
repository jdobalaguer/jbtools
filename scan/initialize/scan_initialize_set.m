
function scan = scan_initialize_set(scan)
    %% scan = SCAN_INITIALIZE_SET(scan)
    % set general struct
    % see also scan_initialize
    
    %% WARNING
    %#ok<*FPARK,*ALIGN>
    
    %% FUNCTION
    
    % directory
    scan.dire.root                  = pwd();
    scan.dire.spm                   = [fileparts(which('spm.m')),filesep];
    scan.dire.mask                  = [scan.dire.root,filesep,'data',filesep,'mask',filesep];
    
    dire_dicom();
    dire_nii();
    if isfield(scan,'glm'),     dire_glm([scan.dire.root,filesep,'data',filesep,'glm',filesep,scan.glm.name,filesep]);
    end
    if isfield(scan,'ppi'),     dire_ppi([scan.dire.root,filesep,'data',filesep,'ppi',filesep,scan.glm.name,filesep]);
                                dire_glm(scan.dire.ppi.glm);
    end
    if isfield(scan,'mvpa'),    dire_mvpa();
                                dire_glm(scan.dire.mvpa.glm);
    end
    
    % file
    scan.file.T1 = [scan.dire.spm,'templates/T1.nii,1'];
    if isfield(scan,'mvpa') && isfield(scan.mvpa,'mask') && ~isempty(scan.mvpa.mask), scan.file.mvpa_mask = [scan.dire.mask,scan.mvpa.mask,'.img,1']; end
    
    % subject
    if ~isfield(scan,'subject'), scan.subject = struct(); end
    assert(~isfield(scan.subject,'u') || ~isfield(scan.subject,'r'), 'scan_parameters: error. only one of subject.u and subject.r must be specified');
    if ~isfield(scan.subject,'u')
        if ~isfield(scan.subject,'r'),      scan.subject.r = []; end
        if ~isfield(scan.dire.nii,'subs'),  scan.subject.u = [];
        else                                scan.subject.u   = 1:size(scan.dire.nii.subs, 1);  scan.subject.u(ismember(scan.subject.u,scan.subject.r)) = [];
        end
        scan.subject     = rmfield(scan.subject,'r');
    end
    scan.subject.n   = length(scan.subject.u);
    
    %% SORT
    scan = struct_sort(scan);
    
    %% AUXILIAR
    
    % dicom
    function dire_dicom()
        if isfield(scan,'dicom'),
            scan.dire.dicom             = struct();
            scan.dire.dicom.root        = [pwd(),filesep,'data',filesep,'dicom',filesep];
            scan.dire.dicom.subs        = dir([scan.dire.dicom.root,'sub_*']); scan.dire.dicom.subs = strcat(scan.dire.dicom.root,strvcat(scan.dire.dicom.subs.name),filesep);
            scan.dire.dicom.strs        = strcat(scan.dire.dicom.subs,filesep,scan.dicom.str,filesep);
            scan.dire.dicom.epi         = strcat(scan.dire.dicom.subs,filesep,scan.dicom.epi,filesep);
    end;end

    % nii
    function dire_nii()
        scan.dire.nii               = struct();
        scan.dire.nii.root          = [scan.dire.root,filesep,'data',filesep,'nii',filesep];
        scan.dire.nii.subs          = dir([scan.dire.nii.root,'sub_*']);
        if isempty(scan.dire.nii.subs), scan.dire.nii = rmfield(scan.dire.nii,'subs');
        else    scan.dire.nii.subs          = strcat(scan.dire.nii.root,strvcat(scan.dire.nii.subs.name),'/');
                scan.dire.nii.epi4          = strcat(scan.dire.nii.subs,'epi4',filesep);
                scan.dire.nii.epi3          = strcat(scan.dire.nii.subs,'epi3',filesep);
                scan.dire.nii.str           = strcat(scan.dire.nii.subs,'str',filesep);
    end;end

    % glm
    function dire_glm(root)
        scan.dire.glm               = struct();
        scan.dire.glm.root          = root;
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

    % ppi
    function dire_ppi(root)
        scan.dire.ppi               = struct();
        scan.dire.ppi.root          = root;
        scan.dire.ppi.glm           = scan.dire.ppi.root;
    end
    
    % mvpa
    function dire_mvpa()
        scan.dire.mvpa              = struct();
        scan.dire.mvpa.root         = [scan.dire.root,filesep,'data',filesep,'mvpa',filesep,scan.mvpa.name,filesep];
        if isempty(scan.mvpa.glm),
            % this comes from "scan_mvpa_glmdx" or "scan_mvpa_glmrsa"
            scan.dire.mvpa.glm      = [scan.dire.mvpa.root,'glm',filesep];
        else
            % this comes from scan_mvpa_glm
            scan.dire.mvpa.glm      = [scan.dire.root,filesep,'data',filesep,'mvpa',filesep,'glm', filesep,scan.mvpa.glm,filesep];
            scan.mvpa.variable.glm = scan.mvpa.glm;
        end
        scan.dire.mvpa.template     = [scan.dire.root,filesep,'data',filesep,'mvpa',filesep,'template', filesep];
        scan.dire.mvpa.mvpa         = [scan.dire.mvpa.root,'mvpa',filesep];
        scan.dire.mvpa.mask         = [scan.dire.mvpa.root,'mask',filesep];
        scan.dire.mvpa.map          = [scan.dire.mvpa.root,'map', filesep];
    end
end