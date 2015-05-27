
function scan = scan_initialize_template(type)
    %% scan = SCAN_INITIALIZE_TEMPLATE()
    % template with default values of [scan]
    % to list main functions, try
    %   >> scan;
    
    %% function
    
    % parameter
    scan.parameter.scanner.nslices = []; ... scanner
    scan.parameter.scanner.tr      = [];
    scan.parameter.scanner.ordsl   = [];
    scan.parameter.scanner.refsl   = [];
    scan.parameter.scanner.reft0   = [];
    scan.parameter.analysis.voxs   = 4;  ... analysis
    scan.parameter.path.subject    = {}; ... path
    scan.parameter.path.session    = {};
    
    % subject
    scan.subject.selection = [];
    scan.subject.remove    = [];
    
    % directory
    scan.directory.root             = [pwd(),filesep];
    scan.directory.spm              = [fileparts(which('spm.m')),filesep()];
    scan.directory.dicom            = [scan.directory.root,'data',filesep,'dicom',filesep];
    scan.directory.nii              = [scan.directory.root,'data',filesep,'nii',filesep];
    scan.directory.mask             = [scan.directory.root,'data',filesep,'mask',filesep];
    scan.directory.glm              = [scan.directory.root,'data',filesep,'glm',filesep];
    scan.directory.ppi              = [scan.directory.root,'data',filesep,'glm',filesep];
    scan.directory.tbte             = [scan.directory.root,'data',filesep,'tbte',filesep];
    scan.directory.mvpa             = [scan.directory.root,'data',filesep,'mvpa',filesep];
    scan.directory.rsa              = [scan.directory.root,'data',filesep,'rsa',filesep];
    
    % file
    scan.file.template.t1           = [scan.directory.spm,'templates',filesep,'T1.nii'];
    scan.file.template.t2           = [scan.directory.spm,'templates',filesep,'T2.nii'];
    scan.file.template.epi          = [scan.directory.spm,'templates',filesep,'EPI.nii'];
    scan.file.nii                   = struct();
    
    % job
    scan.job                        = scan_job_template(type);
    
    % running
    scan.running.subject.unique     = [];
    scan.running.subject.number     = 0;
    scan.running.subject.session    = [];
    scan.running.directory.job      = '';
    scan.running.file.save.scan     = '';
    scan.running.file.save.caller   = '';
    
    % result
    scan.result = struct();
end
