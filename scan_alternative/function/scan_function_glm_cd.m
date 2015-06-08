
function scan = scan_function_glm_cd(scan)
    %% scan = SCAN_FUNCTION_GLM_CD(scan)
    % define "change directory" functions to [scan.running.directory]
    % to list main functions, try
    %   >> help scan;

    %% function
    if ~scan.running.flag.function, return; end
    
    scan_tool_print(scan,false,'\nAdd function (cd) : ');
    scan.function.cd = auxiliar(scan.running.directory);

    %% nested
    function f = auxiliar(v)
        switch class(v)
            case 'char'
                f = @auxiliar_cd;
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
        function auxiliar_cd(varargin)
            if nargin~=0 % || strcmp(varargin{1},'help')
                scan_tool_help('@cd()','This function changes to a given directory matched in [scan.running.directory]');
                return;
            end
            cd(v);
        end
    end
end