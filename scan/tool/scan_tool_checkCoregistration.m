
function scan_tool_checkCoregistration(scan)
    %% SCAN_TOOL_CHECKCOREGISTRATION(scan)
    % predefined method
    % to list main functions, try
    %   >> help scan;
    % see also SCAN_TOOL_CHECK
    
    %% function
    scan_tool_check(scan,{'epi3:realignment', 'structural:image', 'structural:coregistration'},...
                         {'mean',             'first',            'first'});
end
