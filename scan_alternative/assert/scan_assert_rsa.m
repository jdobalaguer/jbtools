
function scan = scan_assert_rsa(scan)
    %% scan = SCAN_ASSERT_RSA(scan)
    % assert [scan] struct
    % to list main functions, try
    %   >> help scan;
    
    %% function
    
    % model function
    for i_model = 1:numel(scan.job.model)
        func = scan.job.model(i_model).function;
        scan_tool_assert(scan,~func_isnested(func),  'Model functions cannot be nested.');
        scan_tool_assert(scan,~func_isformula(func), 'Model functions cannot be a formula.');
        
        func = scan.job.model(i_model).filter;
        scan_tool_assert(scan,~func_isnested(func),  'Model filters cannot be nested.');
        scan_tool_assert(scan,~func_isformula(func), 'Model filters cannot be a formula.');
    end
    
    scan_tool_assert(scan,exist('searchlightMapping_fMRI.m','file') == 2,'Please add RSA-toolbox to the path');
end
