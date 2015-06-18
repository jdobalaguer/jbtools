
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
    
    % subject
    for i_subject = 1:scan.running.subject.number
        scan.running.mask(i_subject) = struct('file',{''},'mask',{[]},'shape',{[nan,nan,nan]});
        switch scan.job.mask.type
            case 'individual'
                scan.running.mask(i_subject).file = fullfile(scan.running.directory.mask.individual{i_subject},scan.job.mask.file);
            case 'common'
                scan.running.mask(i_subject).file = fullfile(scan.running.directory.mask.common,scan.job.mask.file);
            otherwise
                scan_tool_error(scan,'scan.job.mask.type not valid',scan.job.mask.type);
        end
        [scan.running.mask(i_subject).mask,scan.running.mask(i_subject).shape] = scan_nifti_load(scan.running.mask(i_subject).file);
        
        % wait
        scan_tool_progress(scan,[]);
    end
    scan_tool_progress(scan,0);
end
