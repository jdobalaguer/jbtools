
function scan = scan_tool_hdd(scan,mode,field)
    %% scan = SCAN_TOOL_HDD(scan,field)
    % if the size of scan is bigger than [scan.parameter.analysis.hdd]
    % save some fields in the hard-drive in [scan.file.save.hdd].
    % if [field] is undefined, the function will load everything, or save nothing.
    % scan  : [scan] struct
    % mode  : one of {'save','load'}
    % field : cell of strings with the fields that left behind (in the HDD)
    
    %% function
    w = whos('scan');
    if w.bytes < scan.parameter.analysis.hdd, return; end
    
    % warning
    scan_tool_warning(scan,false,'this has not been implemented yet.');
    
    switch mode
        % load
        case 'load'
            
        % save
        case 'save'
            
        % otherwise
        otherwise
            scan_tool_warning(scan,false,'mode "%s" not valid',mode);
    end
    
end