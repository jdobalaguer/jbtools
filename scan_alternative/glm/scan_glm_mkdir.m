
function scan = scan_glm_mkdir(scan)
    %% scan = SCAN_GLM_MKDIR(scan)
    % create new directories before running the glm
    % to list main functions, try
    %   >> help scan;
    
    %% function
    
    % job
    file_mkdir(scan.running.directory.job);
    
    % first level
    if scan.running.flag.design
        for i_subject = 1:scan.running.subject.number
            file_mkdir(scan.running.directory.original.first{i_subject});
        end
    end
    
    % second level
    if scan.running.flag.second
        file_mkdir(scan.running.directory.original.second);
    end
    
    % copy
    for i_subject = 1:scan.running.subject.number
        if scan.job.copyFolder(1),      file_mkdir(scan.running.directory.copy.first.beta{i_subject});      end
        if scan.job.copyFolder(2),      file_mkdir(scan.running.directory.copy.first.contrast{i_subject});  end
        if scan.job.copyFolder(3),      file_mkdir(scan.running.directory.copy.first.statistic{i_subject}); end
    end
    if scan.job.copyFolder(4),      file_mkdir(scan.running.directory.copy.second.beta);        end
    if scan.job.copyFolder(5),      file_mkdir(scan.running.directory.copy.second.contrast);    end
    if scan.job.copyFolder(6),      file_mkdir(scan.running.directory.copy.second.statistic);   end
    if scan.job.copyFolder(7),      file_mkdir(scan.running.directory.copy.spm);                end
end
