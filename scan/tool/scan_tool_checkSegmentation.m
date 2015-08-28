
function scan_tool_checkSegmentation(scan)
    %% SCAN_TOOL_CHECKSEGMENTATION(scan)
    % predefined method
    % to list main functions, try
    %   >> help scan;
    % see also SCAN_TOOL_CHECK
    
    %% function
    scan_tool_check(scan,{'structural:coregistration', 'structural:segmentation'},...
                         {'first',                     'all'});
end
