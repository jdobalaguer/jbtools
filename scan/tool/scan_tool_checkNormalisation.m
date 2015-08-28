
function scan_tool_checkNormalisation(scan)
    %% SCAN_TOOL_CHECKNORMALISATION(scan)
    % predefined method
    % to list main functions, try
    %   >> help scan;
    % see also SCAN_TOOL_CHECK
    
    %% function
    scan_tool_check(scan,{'structural:normalisation','epi3:normalisation'},...
                         {'first',                     'mean'});
end
