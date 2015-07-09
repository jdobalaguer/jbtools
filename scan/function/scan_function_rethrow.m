
function scan = scan_function_rethrow(scan)
    %% scan = SCAN_FUNCTION_RETHROW(scan)
    % define "rethrow" function
    % to list main functions, try
    %   >> help scan;

    %% function
    if ~struct_isfield(scan,'running.flag.function'), return; end
    if ~scan.running.flag.function, return; end
    scan.function.rethrow = @auxiliar_rethrow;
end

%% auxiliar
function auxiliar_rethrow(varargin)
    if ~nargin, return; end
    assertStruct(varargin{1}); tcan = varargin{1};
    if nargin~=1
        scan_tool_help('@rethrow(scan)','This function rethrows the last error');
        return;
    end
    rethrow(tcan.result.error);
end
