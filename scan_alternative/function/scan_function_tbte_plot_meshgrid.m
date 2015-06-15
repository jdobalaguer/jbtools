
function scan = scan_function_tbte_plot_meshgrid(scan)
    %% scan = SCAN_FUNCTION_TBTE_PLOT_MESHGRID(scan)
    % define the function @plot.meshgrid
    % to list main functions, try
    %   >> help scan;
    
    %% function
    if ~scan.running.flag.function,   return; end
    scan.function.plot.meshgrid = @auxiliar_meshgrid;
    
    %% nested
    function varargout = auxiliar_meshgrid(varargin)
        varargout = cell(1,nargout);
        if nargin<3 || strcmp(varargin{1},'help')
            scan_tool_help('mesh = @meshgrid(name,mask,x[,y])','This function plots the estimated betas within the region of interest [mask] for a particular regressor [name]. [mask] is a the path to a nii/img file relative to [scan.directory.mask]. [v#] are vectors with integers that specifies how the data should be splitted (i.e. categorical regressors).');
            return;
        end
        
        % default
        [name,mask] = deal(varargin{1:2});
        vector = cellfun(@mat2vec,varargin(3:end),'UniformOutput',false);
        
        % assert
        if ~ischar(mask), auxiliar_meshgrid('help'); return; end
        if ~ischar(name), auxiliar_meshgrid('help'); return; end
        
        % get mesh
        mesh = scan.function.get.meshgrid(name,mask,vector{:});
        mesh = nanmean(mesh,2);
        s = size(mesh);
        n = length(s);
        m = mat_reshape(nanmean(mesh,1),s(3:n));
        e = mat_reshape(nanste (mesh,1),s(3:n));
        
        % figure
        fig_figure();
        fig_bare(m,e,'parula',num2leg(1:s(3),'x(%d)'),num2leg(1:s(4),'y(%d)'));
    end
end
