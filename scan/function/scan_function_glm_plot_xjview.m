
function scan = scan_function_glm_plot_xjview(scan)
    %% scan = SCAN_FUNCTION_GLM_PLOT_XJVIEW(scan)
    % define functions @plot.xjview
    % to list main functions, try
    %   >> help scan;

    %% function
    if ~scan.running.flag.function, return; end
    scan.function.plot.xjview = @auxiliar_xjview;
end

%% auxiliar
function auxiliar_xjview(varargin)
    if ~nargin, return; end
    assertStruct(varargin{1}); tcan = varargin{1};
    if nargin~=3 || strcmp(varargin{2},'help')
        scan_tool_help(tcan,'@plot.xjview(scan,contrast,order)','This function opens XjView with a particular contrast. [contrast] needs to be a string with the name of the contrast. [order] needs to be the ''order'' of the contrast.');
        return;
    end
    
    % default
    [contrast,order] = varargin{2:3};
    
    % path
    path = sprintf('%s%s_%03i.nii',tcan.running.directory.copy.second.statistic,contrast,order);
    if ~file_exist(path), scan_tool_warning(tcan,false,'file not found "%s"',path); return; end
    
    % xjview
    xjview(path);
end
