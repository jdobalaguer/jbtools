
function scan = scan_save_caller(scan,caller)
    %% scan = SCAN_SAVE_CALLER(scan[,caller])
    % save the caller script
    % to list main functions, try
    %   >> help scan;

    %% function
    
    % default
    func_default('caller',2);
    
    % make directory
    file_mkdir(fileparts(scan.running.file.save.caller));
    
    % move previous folder
    if file_match(scan.running.file.save.caller)
        d = dir(scan.running.file.save.caller); d = d.date;
        f = strcat(file_next(scan.running.file.save.caller),' ',d,file_ext(scan.running.file.save.caller));
        movefile(scan.running.file.save.caller,f);
    end
    
    % copy file
    if isempty(func_caller(caller))
        scan_tool_warning(scan,true,'Nothing to save');
        return;
    end
    copyfile(which(func_caller(caller)),scan.running.file.save.caller);
end
