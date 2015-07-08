
function scan = scan_function_rsa_plot_comparison(scan)
    %% scan = SCAN_FUNCTION_RSA_PLOT_COMPARISON(scan)
    % plot the betas of the comparison
    % to list main functions, try
    %   >> help scan;

    %% function
    if ~scan.running.flag.function, return; end
    scan.function.plot.comparison = @auxiliar_plot_comparison;
end

%% auxiliar
function varargout = auxiliar_plot_comparison(varargin)
    varargout = cell(1,nargin);
    if ~nargin, return; end
    assertStruct(varargin{1}); tcan = varargin{1};
    if nargin<2 || strcmp(varargin{2},'help')
        scan_tool_help('@plot.comparison(scan,i_mask)','This function plots the result of the comparison for a certain mask. The mask is an index that corresponds to a possibly modified by the searchlight (see [scan.running.mask]).');
        return;
    end

    % default
    i_mask = varargin{2};
    plot_args = struct_default(pair2struct(varargin{5:end}),scan_function_plot_args);

    % assert
    if ~isscalar(i_mask) || ~isnumeric(i_mask), auxiliar_plot_comparison('help'); return; end

    % get
    beta = nan(tcan.running.subject.number,max(tcan.running.subject.session),length(tcan.job.model));
    for i_subject = 1:tcan.running.subject.number
        for i_session = 1:tcan.running.subject.session(i_subject)
            beta(i_subject,i_session,:) = tcan.running.comparison{i_subject}{i_session}(i_mask).beta;
        end
    end

    % return
    varargout = {beta};

    % plot
    if ~nargout
        beta = mean(beta,2);
        m = meeze (beta,1);
        e = steeze(beta,1);
        fig_figure(plot_args.figure);
        fig_bare(m,e,plot_args.color_fill,{tcan.job.model.model});
        fig_fontname([],plot_args.fontname);
        fig_fontsize([],plot_args.fontsize);
    end
end
