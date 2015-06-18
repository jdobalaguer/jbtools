
function scan = scan_rsa_mask(scan)
    %% scan = SCAN_RSA_MASK(scan)
    % load mask(s)
    % to list main functions, try
    %   >> help scan;
    
    %% function
    if ~scan.running.flag.load, return; end
    
    % print
    scan_tool_print(scan,false,'\nLoad mask : ');
    scan_tool_progress(scan,scan.running.subject.number);
    
    for i_subject = 1:scan.running.subject.number
        scan.running.mask(i_subject) = struct('file',{''},'mask',{[]},'shape',{[nan,nan,nan]});
        if isempty(scan.job.mask)
            % mask not defined, load whole-brain mask
            scan.running.mask(i_subject).file = fullfile(scan.directory.mask,'individual',scan.parameter.path.subject{i_subject},scan.running.glm.job.image,'wholebrain.nii');
            [scan.running.mask(i_subject).mask,scan.running.mask(i_subject).shape] = scan_nifti_load(scan.running.mask(i_subject).file);
        else
            % load mask
            scan.running.mask(i_subject).file = fullfile(scan.directory.mask,'common',scan.job.mask);
            [scan.running.mask(i_subject).mask,scan.running.mask(i_subject).shape] = scan_nifti_load(scan.running.mask(i_subject).file);
        end
        
        
        % wait
        scan_tool_progress(scan,[]);
    end
    scan_tool_progress(scan,0);
end
