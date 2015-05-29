
function scan = scan_glm_concat(scan)
    %% scan = SCAN_GLM_CONCAT(scan)
    % make last changes for the session concatenation
    % to list main functions, try
    %   >> help scan;

    %% function
    if ~scan.running.flag.design, return; end
    if ~scan.job.concatSessions,  return; end
    
    % print
    fprintf('Conatenate sessions (file) : \n');
    func_wait(sum(scan.running.subject.session));
    
    % concatenate files
    for i_subject = 1:scan.running.subject.number
        u_image = {'image','realignment','normalisation','smooth'};
        for i_image = 1:length(u_image)
            scan.running.file.nii.epi3.(u_image{i_image}){i_subject} = {vertcat(scan.running.file.nii.epi3.(u_image{i_image}){i_subject}{:})};
        end
        func_wait();
    end
    func_wait(0);
    
    % change sessions
    scan.running.subject.session(:) = 1;
    
    % save scan
    scan_job_save_scan(scan);
end