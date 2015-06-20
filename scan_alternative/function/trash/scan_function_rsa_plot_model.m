
function scan = scan_function_rsa_plot_model(scan)
    %% scan = SCAN_FUNCTION_RSA_PLOT_MODEL(scan)
    % plot RDMs
    % to list main functions, try
    %   >> help scan;

    %% function
    if ~scan.running.flag.function, return; end
    scan.function.plot.model = @auxiliar_plot_model;
end

%% auxiliar
function auxiliar_plot_model(varargin)
    if ~nargin, return; end
    assertStruct(varargin{1}); tcan = varargin{1};
    if nargin<2 || strcmp(varargin{2},'help')
        scan_tool_help('@plot.model(scan,i_model,u_subject,u_session)','This function plots the RDM from a certain model and a set of subjects/sessions. The model is an index that corresponds to a model (see [scan.job.model]). If [u_subject] or [u_session] are not specified, all available subjects/sessions are displayed. Any combination model/subject/session that doesn''t exist will be ignored.');
        return;
    end

    % default
    varargin(end+1:4) = {[]};
    [i_model,u_subject,u_session] = varargin{2:4};
    func_default('u_subject',1:tcan.running.subject.number);
    func_default('u_session',1:max(tcan.running.subject.session));
    plot_args = struct_default(pair2struct(varargin{5:end}),scan_function_plot_args);

    % assert
    if ~isscalar(i_model) || ~isnumeric(i_model), auxiliar_plot_model('help'); return; end
    if ~isnumeric(u_subject),                     auxiliar_plot_model('help'); return; end
    if ~isnumeric(u_session),                     auxiliar_plot_model('help'); return; end

    % plot
    fig_figure(plot_args.figure);
    for i_subject = 1:length(u_subject)
        for i_session = 1:length(u_session)
            if length(tcan.running.model) < i_subject,                    continue; end
            if length(tcan.running.model{i_subject}) < i_session,         continue; end
            if length(tcan.running.model{i_subject}{i_session}) < i_model, continue; end
            subplot(length(u_subject),length(u_session),(i_subject-1)*length(u_session)+i_session);
            imagesc(squareform(tcan.running.model{i_subject}{i_session}(i_model).vector));
            column = [tcan.running.model{i_subject}{i_session}(i_model).column{:}]; column = {column.name};
            step = ceil((length(column)-1) ./ min(length(column)-1,plot_args.max_ticks));
            fig_axis(struct('xtick',{1:step:length(column)},'xticklabel',{column(1:step:end)},'ytick',[]));
            set(gca(),'XTickLabelRotation',90);
        end
    end
    fig_fontname([],plot_args.fontname);
    fig_fontsize([],plot_args.fontsize);
end
