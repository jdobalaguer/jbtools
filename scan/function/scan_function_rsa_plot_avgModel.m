
function scan = scan_function_rsa_plot_avgModel(scan)
    %% scan = SCAN_FUNCTION_RSA_PLOT_AVGMODEL(scan)
    % define function @plot.avgRdmModel
    % to list main functions, try
    %   >> help scan;

    %% function
    if ~scan.running.flag.function, return; end
    scan.function.plot.avgModel = @auxiliar_avgModel;

end

%% auxiliar
function auxiliar_avgModel(varargin)
    if ~nargin, return; end
    assertStruct(varargin{1}); tcan = varargin{1};
    if nargin<2 || strcmp(varargin{2},'help')
        scan_tool_help(tcan,'@model(scan,i_model)','This function plots the model RDM.');
        return;
    end

    % default
    [i_model] = varargin{2};
    plot_args = struct_default(pair2struct(varargin{3:end}),scan_function_plot_args());
    
    % get RDM
    rdm = tcan.function.get.avgModel(tcan,i_model);
    rdm = squareform(rdm);
    
    % get labels
    if tcan.job.padSessions
        u_condition = mat2vec(1:length(tcan.job.glm.condition));
        u_session   = unique(tcan.running.load.session,'stable');
        [x_condition,~] = ndgrid(u_condition,u_session);
        label       = tcan.job.glm.condition(x_condition(:));
    else
        ii_subject = (tcan.running.load.subject == 1);
        ii_session = (tcan.running.load.session == 1);
        name    = tcan.running.load.name(ii_subject & ii_session);
        version = tcan.running.load.version(ii_subject & ii_session);
        label   = strcat(name,' ',version);
    end

    % figure
    n = size(rdm,1);
%     fig_figure(plot_args.figure);
%     subplot(plot_args.subplot(1),plot_args.subplot(2),plot_args.subplot(3));
    fig_pimage(rdm); set(gca,'YDir','reverse');
    colormap(fig_color(plot_args.color_scheme,size(colormap(),1)));
    sa.xlim       = [0,n] + 0.5;
    sa.xtick      = [];
    sa.xticklabel = {};
    sa.ylim       = [0,n] + 0.5;
    sa.ytick      = 1:n;
    sa.yticklabel = label;
    fig_axis(sa);
    colorbar();
    axis(gca(),'square');
end
