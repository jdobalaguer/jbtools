
function scan = scan_function_rsa_plot_model(scan)
    %% scan = SCAN_FUNCTION_RSA_PLOT_MODEL(scan)
    % define function @plot.model
    % to list main functions, try
    %   >> help scan;

    %% function
    if ~scan.running.flag.function, return; end
    scan.function.plot.model = @auxiliar_model;

end

%% auxiliar
function auxiliar_model(varargin)
    if ~nargin, return; end
    assertStruct(varargin{1}); tcan = varargin{1};
    if nargin<4 || strcmp(varargin{2},'help')
        scan_tool_help(tcan,'@model(scan,i_subject,i_session,i_model)','This function plots the model RDM.');
        return;
    end

    % default
    [i_subject,i_session,i_model] = varargin{2:4};
    plot_args = struct_default(pair2struct(varargin{5:end}),scan_function_plot_args());
    
    % get RDM
    rdm = tcan.function.get.model(tcan,i_subject,i_session,i_model);
    rdm = squareform(rdm);
    rdm(logical(eye(size(rdm)))) = nan;

    % figure
    n = size(rdm,1);
    fig_figure(plot_args.figure);
    subplot(plot_args.subplot(1),plot_args.subplot(2),plot_args.subplot(3));
    fig_pimage(rdm); set(gca,'YDir','reverse');
    colormap(fig_color(plot_args.color_scheme,size(colormap(),1)));
    sa.xlim       = [0,n] + 0.5;
    sa.xtick      = [];
    sa.xticklabel = {};
    sa.ylim       = [0,n] + 0.5;
    sa.ytick      = 1:n;
    sa.yticklabel = tcan.running.model(i_model).rdm{i_subject}{i_session}.name;
    sa.title      = tcan.running.model(i_model).name;
    fig_axis(sa);
    colorbar();
    axis(gca(),'square');
end
