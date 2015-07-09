
function scan = scan_assert_spm(scan)
    %% scan = SCAN_ASSERT_SPM(scan)
    % assert [scan] struct
    % to list main functions, try
    %   >> help scan;
    
    %% function
    scan_tool_assert(scan,exist('spm.m','file') == 2,'Please add SPM to the path');
end
