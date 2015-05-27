
function scan = scan_job_save_scan(scan)
    %% scan = SCAN_JOB_SAVE_SCAN(scan)
    % save the [scan] struct
    % to list main functions, try
    %   >> scan;

    %% function
    file_mkdir(fileparts(scan.running.file.save.scan));
    save(scan.running.file.save.scan,'scan','-v7.3');
end
