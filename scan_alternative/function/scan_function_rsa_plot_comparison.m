
function scan = scan_function_rsa_plot_comparison(scan)
    %% scan = SCAN_FUNCTION_RSA_PLOT_COMPARISON(scan)
    % plot the betas of the comparison
    % to list main functions, try
    %   >> help scan;

    %% function
    if ~scan.running.flag.function, return; end
    
    scan_tool_print(scan,false,'\nAdd function (plot.comparison) : ');
    scan.function.plot.comparison = @auxiliar_plot_comparison;

    %% nested
    function beta = auxiliar_plot_comparison(varargin)
        if nargin~=1 || strcmp(varargin{1},'help')
            scan_tool_help('@plot.comparison(i_mask)','This function plots the result of the comparison for a certain mask. The mask is an index that corresponds to a possibly modified by the searchlight (see [scan.running.mask]).');
            return;
        end
        
        % default
        i_mask = varargin{1};
        
        % assert
        if ~isscalar(i_mask) || ~isnumeric(i_mask), auxiliar_plot_comparison('help'); return; end
        
        % get
        beta = nan(scan.running.subject.number,max(scan.running.subject.session),length(scan.job.model));
        for i_subject = 1:scan.running.subject.number
            for i_session = 1:scan.running.subject.session(i_subject)
                beta(i_subject,i_session,:) = scan.running.comparison{i_subject}{i_session}(i_mask).beta;
            end
        end
        
        % plot
        if ~nargout
            beta = mean(beta,2);
            m = meeze (beta,1);
            e = steeze(beta,1);
            fig_figure();
            fig_bare(m,e,ones(1,3)*5/6,{scan.job.model.model});
            fig_fontname([],'Calibri');
            fig_fontsize([],16);
        end
    end
end
