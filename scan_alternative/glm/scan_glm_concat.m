
function scan = scan_glm_concat(scan)
    %% scan = SCAN_GLM_CONCAT(scan)
    % make last changes for the session concatenation
    % to list main functions, try
    %   >> help scan;

    %% function
    if ~scan.running.flag.design, return; end
    if ~scan.job.concatSessions,  return; end
    
    % print
    scan_tool_print(scan,false,'\nConatenate session (file) : ');
    scan_tool_progress(scan,sum(scan.running.subject.session));
    
    % concatenate files
    for i_subject = 1:scan.running.subject.number
        u_image = {'image','realignment','normalisation','smooth'};
        for i_image = 1:length(u_image)
            if isfield(scan.running.file.nii.epi3,u_image{i_image})
                scan.running.file.nii.epi3.(u_image{i_image}){i_subject} = {vertcat(scan.running.file.nii.epi3.(u_image{i_image}){i_subject}{:})};
            end
        end
        scan_tool_progress(scan,[]);
    end
    scan_tool_progress(scan,0);
    
    % change sessions
    scan.running.subject.session(:) = 1;
end