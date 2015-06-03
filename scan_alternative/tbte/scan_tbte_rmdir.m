
function scan = scan_tbte_rmdir(scan)
    %% scan = SCAN_TBTE_RMDIR(scan)
    % delete old directories before running the tbte
    % to list main functions, try
    %   >> help scan;
    
    %% function
    
    % first level analyses
    if scan.running.flag.design,
        for i_subject = 1:scan.running.subject.number
            file_rmdir(scan.running.directory.original.first{i_subject});
        end
    end
end
