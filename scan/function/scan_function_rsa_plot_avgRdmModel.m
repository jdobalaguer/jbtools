
function scan = scan_function_rsa_plot_avgRdmModel(scan)
    %% scan = SCAN_FUNCTION_RSA_PLOT_AVGRDMMODEL(scan)
    % define function @plot.avgRdmModel
    % to list main functions, try
    %   >> help scan;

    %% function
    if ~scan.running.flag.function, return; end
    scan.function.plot.avgRdmModel = @auxiliar_rdmModel;

end

%% auxiliar
function auxiliar_rdmModel(varargin)
    if ~nargin, return; end
    assertStruct(varargin{1}); tcan = varargin{1};
    if nargin<3 || strcmp(varargin{2},'help')
        scan_tool_help(tcan,'@model(scan,i_model,mask)','This function plots the model RDM.');
        return;
    end

    % default
    [i_model,mask] = varargin{2:3};
    plot_args = struct_default(pair2struct(varargin{4:end}),scan_function_plot_args());
    
    % get RDM
    rdm = tcan.function.get.avgRdmModel(tcan,i_model,mask);
    rdm = squareform(rdm);
    
    % get labels
    ii_subject = (tcan.running.load.subject == 1);
    ii_session = (tcan.running.load.session == 1);
    name    = tcan.running.load.name(ii_subject & ii_session);
    version = tcan.running.load.version(ii_subject & ii_session);
    label   = strcat(name,' ',version);

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
