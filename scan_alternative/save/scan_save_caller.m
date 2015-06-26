
function scan = scan_save_caller(scan)
    %% scan = SCAN_SAVE_CALLER(scan)
    % save the caller script
    % to list main functions, try
    %   >> help scan;

    %% function
    
    % make directory
    file_mkdir(fileparts(scan.running.file.save.caller));
    
    % move previous folder
    if file_match(scan.running.file.save.caller)
        d = dir(scan.running.file.save.caller); d = d.date;
        f = strcat(file_next(scan.running.file.save.caller),' ',d,file_ext(scan.running.file.save.caller));
        movefile(scan.running.file.save.caller,f);
    end
    
    % copy file
    if isempty(func_caller(2))
        scan_tool_warning(scan,true,'Nothing to save');
        return;
    end
    copyfile(which(func_caller(2)),scan.running.file.save.caller);
end
