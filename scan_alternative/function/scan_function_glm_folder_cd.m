
function scan = scan_function_glm_folder_cd(scan)
    %% scan = SCAN_FUNCTION_GLM_FOLDER_CD(scan)
    % define functions @folder.cd
    % to list main functions, try
    %   >> help scan;

    %% function
    if ~scan.running.flag.function, return; end
    scan.function.folder.cd = auxiliar(scan.running.directory);

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
                scan_tool_help(scan,'@cd()','This function changes to a given directory matched in [scan.running.directory]');
                return;
            end
            cd(v);
        end
    end
end
