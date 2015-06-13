
function scan = scan_save_hdd(scan,input,output)
    %% scan = SCAN_SAVE_HDD(scan,field)
    % if the size of scan is bigger than [scan.parameter.analysis.hdd]
    % save some fields in the hard-drive in [scan.file.save.hdd] to free the RAM.
    % if [input]  is undefined, the function won't load anything
    % if [output] is undefined, the function won't save anything
    % scan   : [scan] struct
    % input  : cell of strings with the fields that can be saved in the HDD
    % output : cell of strings with the fields that need be loaded
    
    %% function
    if bytes(scan) < scan.parameter.analysis.hdd, return; end
    
    % warning
    scan_tool_warning(scan,false,'this has not been implemented yet.'); return;
    
    
end