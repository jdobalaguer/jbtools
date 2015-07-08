
function scan = scan_rsa_meta(scan)
    %% scan = SCAN_RSA_META(scan)
    % load metadata from beta files
    % to list main functions, try
    %   >> help scan;
    
    %% function
    if scan_tool_isdone(scan), return; end
    if ~scan.running.flag.load, return; end
    
    % print
    scan_tool_print(scan,false,'\nLoad metadata : ');
    scan_tool_progress(scan,1);
    
    % variables
    name    = scan.running.load.name{1};
    version = scan.running.load.version{1};
    subject = scan.running.load.subject(1);
    session = scan.running.load.session(1);
    order   = scan.running.load.order(1);
    
    % load
    file = fullfile(scan.running.glm.running.directory.copy.first.beta,strcat(name,version),sprintf('subject_%03i session_%03i order_%03i.nii',subject,session,order));
    meta = spm_vol(file);
    meta.fname = '';
    meta.descrip = '';
    private = struct();
    private.dat         = nan(size(meta.private.dat));
    private.mat         = meta.private.mat;
    private.mat_intent  = meta.private.mat_intent;
    private.mat0        = meta.private.mat0;
    private.mat0_intent = meta.private.mat0_intent;
    private.descrip     = '';
    private = struct(private);
    meta.private = private;
    
    % save
    scan.running.meta = meta;
    
    % wait
    scan_tool_progress(scan,0);
    
    % done
    scan = scan_tool_done(scan);
end
