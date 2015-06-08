
function scan = scan_initialize_template(type)
    %% scan = SCAN_INITIALIZE_TEMPLATE()
    % template with default values of [scan]
    % to list main functions, try
    %   >> help scan;
    
    %% function
    
    % parameter
    scan.parameter.scanner.nslices      = []; ... scanner
    scan.parameter.scanner.tr           = [];
    scan.parameter.scanner.ordsl        = [];
    scan.parameter.scanner.refsl        = [];
    scan.parameter.scanner.reft0        = [];
    scan.parameter.analysis.voxs        = 4;  ... analysis
    scan.parameter.analysis.verbose     = true;
    scan.parameter.analysis.wpause      = true;
    scan.parameter.analysis.progress    = true;
    scan.parameter.analysis.hdd         = inf;
    scan.parameter.path.subject         = {}; ... path
    scan.parameter.path.session         = {};
    
    % subject
    scan.subject.selection = [];
    scan.subject.remove    = [];
    scan.subject.session   = [];
    
    % directory
    scan.directory.root             = file_endsep(pwd());
    scan.directory.spm              = file_endsep(fileparts(which('spm.m')));
    scan.directory.data             = file_endsep(fullfile(scan.directory.root,'data'));
    scan.directory.dicom            = file_endsep(fullfile(scan.directory.data,'dicom'));
    scan.directory.nii              = file_endsep(fullfile(scan.directory.data,'nii'));
    scan.directory.preprocess       = file_endsep(fullfile(scan.directory.data,'preprocess'));
    scan.directory.regressor        = file_endsep(fullfile(scan.directory.data,'regressor'));
    scan.directory.mask             = file_endsep(fullfile(scan.directory.data,'mask'));
    scan.directory.glm              = file_endsep(fullfile(scan.directory.data,'glm'));
    scan.directory.tbte             = file_endsep(fullfile(scan.directory.data,'tbte'));
    scan.directory.mvpa             = file_endsep(fullfile(scan.directory.data,'mvpa'));
    scan.directory.rsa              = file_endsep(fullfile(scan.directory.data,'rsa'));
    
    % file
    scan.file.template.t1           = [scan.directory.spm,'templates',filesep,'T1.nii'];
    scan.file.template.t2           = [scan.directory.spm,'templates',filesep,'T2.nii'];
    scan.file.template.epi          = [scan.directory.spm,'templates',filesep,'EPI.nii'];
    
    % job
    scan.job                        = scan_initialize_template_job(type);
    
    % running
    scan.running.subject.unique     = [];
    scan.running.subject.number     = 0;
    scan.running.subject.session    = [];
    scan.running.file.save.scan     = '';
    scan.running.file.save.caller   = '';
    
    % result
    scan.result = struct();
    
    % function
    scan.function = struct();
end
