
function scan = scan_job_save_caller(scan)
    %% scan = SCAN_JOB_SAVE_CALLER(scan)
    % save the caller script
    % to list main functions, try
    %   >> scan;

    %% function
    file_mkdir(fileparts(scan.running.file.save.caller));
    copyfile(which(func_caller(2)),scan.running.file.save.caller);
end
