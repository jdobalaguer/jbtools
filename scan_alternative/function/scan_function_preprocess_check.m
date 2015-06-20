
function scan = scan_function_preprocess_check(scan)
    %% scan = SCAN_FUNCTION_PREPROCESS_CHECK(scan)
    % define "check" function
    % to list main functions, try
    %   >> help scan;

    %% function
    if ~scan.running.flag.function, return; end
    scan.function.check = @auxiliar_check;
end

%% auxiliar
function auxiliar_check(varargin)
    varargout = cell(1,nargin);
    if ~nargin, return; end
    assertStruct(varargin{1}); tcan = varargin{1};

    if true %nargin<4 || strcmp(varargin{2},'help')
        scan_tool_help('fir = @check(scan,subject)','');
        return;
    end

    % default
    %[level,type,mask,contrast] = varargin{2:5};
end
