
function scan = scan_save_caller(scan,caller)
    %% scan = SCAN_SAVE_CALLER(scan[,caller])
    % save the caller script
    % to list main functions, try
    %   >> help scan;

    %% function
    
    % default
    func_default('caller',2);
    
    % move previous folder
    if file_match(scan.running.directory.save.caller)
        d = dir(scan.running.directory.save.caller); d = d.date;
        f = strcat(file_nendsep(scan.running.directory.save.caller),' ',d);
        movefile(scan.running.directory.save.caller,f);
    end
    
    % make directory
    file_mkdir(fileparts(scan.running.directory.save.caller));
    
    % copy file
    while ~isempty(func_caller(caller))
        file_mkdir(scan.running.directory.save.caller);
        copyfile(which(func_caller(caller)),scan.running.directory.save.caller);
        caller = caller + 1;
    end
end
