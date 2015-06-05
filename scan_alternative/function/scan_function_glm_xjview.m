
function scan = scan_function_glm_xjview(scan)
    %% scan = SCAN_FUNCTION_GLM_XJVIEW(scan)
    % define "xjview" functions to [scan.running.directory]
    % to list main functions, try
    %   >> help scan;

    %% function
    if ~scan.running.flag.function, return; end
    
    scan_tool_print(scan,false,'\nAdd function (xjview) : ');
    scan.function.xjview = auxiliar(scan.running.directory);

    %% nested
    function f = auxiliar(v)
        switch class(v)
            case 'char'
                f = @auxiliar_xjview;
            case 'struct'
                u = fieldnames(v);
                for i = 1:length(u)
                    f.(u{i}) = auxiliar(v.(u{i}));
                end
            case 'cell'
                f = cell(size(v));
                for i = 1:numel(v)
                    f{i} = auxiliar(v{i});
                end
        end
        function auxiliar_xjview(varargin)
            if nargin~=0 % || strcmp(varargin{1},'help')
                scan_tool_help('@xjview()','This function changes to a given directory matched in [scan.running.directory] and opens xjview()');
                return;
            end
            cd(v);
            xjview();
        end
    end
end
