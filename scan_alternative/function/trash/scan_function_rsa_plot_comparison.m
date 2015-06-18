
function scan = scan_function_rsa_plot_comparison(scan)
    %% scan = SCAN_FUNCTION_RSA_PLOT_COMPARISON(scan)
    % plot the betas of the comparison
    % to list main functions, try
    %   >> help scan;

    %% function
    if ~scan.running.flag.function, return; end
    scan.function.plot.comparison = @auxiliar_plot_comparison;

    %% nested
    function varargout = auxiliar_plot_comparison(varargin)
        varargout = cell(1,nargout);
        if nargin<1 || strcmp(varargin{1},'help')
            scan_tool_help('@plot.comparison(i_mask)','This function plots the result of the comparison for a certain mask. The mask is an index that corresponds to a possibly modified by the searchlight (see [scan.running.mask]).');
            return;
        end
        
        % default
        i_mask = varargin{1};
        plot_args = struct_default(pair2struct(varargin{5:end}),scan_function_plot_args);
        
        % assert
        if ~isscalar(i_mask) || ~isnumeric(i_mask), auxiliar_plot_comparison('help'); return; end
        
        % get
        beta = nan(scan.running.subject.number,max(scan.running.subject.session),length(scan.job.model));
        for i_subject = 1:scan.running.subject.number
            for i_session = 1:scan.running.subject.session(i_subject)
                beta(i_subject,i_session,:) = scan.running.comparison{i_subject}{i_session}(i_mask).beta;
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
            fig_bare(m,e,plot_args.color_fill,{scan.job.model.model});
            fig_fontname([],plot_args.fontname);
            fig_fontsize([],plot_args.fontsize);
        end
    end
end
