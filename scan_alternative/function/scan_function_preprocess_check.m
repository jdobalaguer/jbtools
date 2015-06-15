
function scan = scan_function_preprocess_check(scan)
    %% scan = SCAN_FUNCTION_PREPROCESS_CHECK(scan)
    % define "check" function
    % to list main functions, try
    %   >> help scan;

    %% function
    if ~scan.running.flag.function, return; end
    scan.function.check = @auxiliar_check;

    %% nested
    function auxiliar_check(varargin)
        if true %nargin<4 || strcmp(varargin{1},'help')
            scan_tool_help('fir = @check()','');
            return;
        end
        
        % default
        %[level,type,mask,contrast] = deal(varargin{1:4});
    end
end
