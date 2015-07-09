
function scan = scan_function_tbte_plot_meshgrid(scan)
    %% scan = SCAN_FUNCTION_TBTE_PLOT_MESHGRID(scan)
    % define the function @plot.meshgrid
    % to list main functions, try
    %   >> help scan;
    
    %% function
    if ~scan.running.flag.function,   return; end
    scan.function.plot.meshgrid = @auxiliar_meshgrid;
end

%% auxiliar
function varargout = auxiliar_meshgrid(varargin)
    varargout = cell(1,nargin);
    if ~nargin, return; end
    assertStruct(varargin{1}); tcan = varargin{1};
    if nargin<4 || strcmp(varargin{2},'help')
        scan_tool_help(tcan,'mesh = @meshgrid(scan,name,mask,x[,y])','This function plots the estimated betas within the region of interest [mask] for a particular regressor [name]. [mask] is a the path to a nii/img file relative to [scan.directory.mask]. [v#] are vectors with integers that specifies how the data should be splitted (i.e. categorical regressors).');
        return;
    end

    % default
    [name,mask] = varargin{2:3};
    vector = cellfun(@mat2vec,varargin(4:end),'UniformOutput',false);

    % assert
    if ~ischar(mask), auxiliar_meshgrid(tcan,'help'); return; end
    if ~ischar(name), auxiliar_meshgrid(tcan,'help'); return; end

    % get mesh
    mesh = tcan.function.get.meshgrid(tcan,name,mask,vector{:});
    mesh = nanmean(mesh,2);
    s = size(mesh);
    n = length(s);
    m = mat_reshape(nanmean(mesh,1),s(3:n));
    e = mat_reshape(nanste (mesh,1),s(3:n));

    % figure
    switch n
        case 3
            fig_figure();
            fig_bare(m,e,'parula',num2leg(1:s(3),'x(%d)'));
        case 4
            fig_figure();
            fig_bare(m,e,'parula',num2leg(1:s(3),'x(%d)'),num2leg(1:s(4),'y(%d)'));
    end
end
