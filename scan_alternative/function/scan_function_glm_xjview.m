
function scan = scan_function_glm_xjview(scan)
    %% scan = SCAN_FUNCTION_GLM_XJVIEW(scan)
    % define "xjview" functions to [scan.running.directory]
    % to list main functions, try
    %   >> help scan;

    %% function
    scan_tool_print(scan,false,'\nAdd function (xjview) : ');
    scan.function.xjview = auxiliar(scan.running.directory);

end

%% auxiliar
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
    function auxiliar_xjview(), cd(v); xjview(); end
end

