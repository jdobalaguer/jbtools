
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
    if nargin<4 || nargin>5 || strcmp(varargin{2},'help')
        scan_tool_help(tcan,'mesh = @meshgrid(scan,name,mask,x[,y])','This function plots the estimated betas within the region of interest [mask] for a particular regressor [name]. [mask] is a the path to a nii/img file relative to [scan.directory.mask]. [x] and [y] are vectors with integers that specifies how the data should be splitted (i.e. categorical regressors).');
        return;
    end

    % default
    [name,mask] = varargin{2:3};
    vector = varargin(4:end);
    vector(3:end) = [];
    vector = cellfun(@mat2vec,vector,'UniformOutput',false);

    % assert
    if ~ischar(mask), auxiliar_meshgrid(tcan,'help'); return; end
    if ~ischar(name), auxiliar_meshgrid(tcan,'help'); return; end

    % get mesh
    mesh = tcan.function.get.meshgrid(tcan,name,mask,vector{:});
    mesh = nanmean(mesh,2); ... average across sessions
    s = size(mesh);
    n = length(s);
    m = mat_reshape(nanmean(mesh,1),s(3:n));
    e = mat_reshape(nanste (mesh,1),s(3:n));
    u = cellfun(@(v)unique(vec_filter(v)),vector,'UniformOutput',false);
    l = cellfun(@(u)strcat('x_{',num2leg(u),'}'),u,'UniformOutput',false);

    % figure
    switch n
        case 3
            fig_figure();
            fig_bare(m,e,'parula',l{1});
        case 4
            fig_figure();
            fig_bare(m,e,'parula',l{1},l{2});
    end
end
