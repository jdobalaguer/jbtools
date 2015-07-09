
function scan = scan_tbte_mkdir(scan)
    %% scan = SCAN_TBTE_MKDIR(scan)
    % create new directories before running the tbte
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
end
