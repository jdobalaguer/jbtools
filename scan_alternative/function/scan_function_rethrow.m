
function scan = scan_function_rethrow(scan)
    %% scan = SCAN_FUNCTION_RETHROW(scan)
    % define "rethrow" function
    % to list main functions, try
    %   >> help scan;

    %% function
    if ~struct_isfield(scan,'running.flag.function'), return; end
    if ~scan.running.flag.function, return; end
    scan.function.rethrow = @auxiliar_rethrow;
    
    %% nested
    function auxiliar_rethrow(varargin)
        if nargin~=0
            scan_tool_help('@rethrow()','This function rethrows the last error');
            return;
        end
        rethrow(scan.result.error);
    end
end
