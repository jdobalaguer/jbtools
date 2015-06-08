
function scan = scan_function_rsa_plot_rdm(scan)
    %% scan = SCAN_FUNCTION_RSA_PLOT_RDM(scan)
    % plot RDMs
    % to list main functions, try
    %   >> help scan;

    %% function
    if ~scan.running.flag.function, return; end
    
    scan_tool_print(scan,false,'\nAdd function (plot.rdm) : ');
    scan.function.plot.rdm = @auxiliar_plot_rdm;

    %% nested
    function auxiliar_plot_rdm(varargin)
        if nargin<1 || strcmp(varargin{1},'help')
            scan_tool_help('@plot.rdm(i_mask,u_subject,u_session)','This function plots the RDM for a certain mask and a set of subjects/sessions. The mask is an index that corresponds to a possibly modified by the searchlight (see [scan.running.mask]). If [u_subject] or [u_session] are not specified, all available subjects/sessions are displayed. Any combination mask/subject/session that doesn''t exist will be ignored.');
            return;
        end
        
        % default
        varargin(end+1:3) = {[]};
        [i_mask,u_subject,u_session] = deal(varargin{1:3});
        func_default('u_subject',1:scan.running.subject.number);
        func_default('u_session',1:max(scan.running.subject.session));
        plot_args = struct_default(pair2struct(varargin{5:end}),scan_function_plot_args);
        
        % assert
        if ~isscalar(i_mask) || ~isnumeric(i_mask), auxiliar_plot_rdm('help'); return; end
        if ~isnumeric(u_subject),                   auxiliar_plot_rdm('help'); return; end
        if ~isnumeric(u_session),                   auxiliar_plot_rdm('help'); return; end
        
        % plot
        fig_figure(plot_args.figure);
        for i_subject = 1:length(u_subject)
            for i_session = 1:length(u_session)
                if length(scan.running.rdm) < i_subject,                    continue; end
                if length(scan.running.rdm{i_subject}) < i_session,         continue; end
                if length(scan.running.rdm{i_subject}{i_session}) < i_mask, continue; end
                subplot(length(u_subject),length(u_session),(i_subject-1)*length(u_session)+i_session);
                imagesc(squareform(scan.running.rdm{i_subject}{i_session}(i_mask).vector));
                step = ceil((scan.running.rdm{i_subject}{i_session}(i_mask).column.number-1) ./ min(scan.running.rdm{i_subject}{i_session}(i_mask).column.number-1,plot_args.max_ticks));
                fig_axis(struct('xtick',{1:step:scan.running.rdm{i_subject}{i_session}(i_mask).column.number},'xticklabel',{scan.running.rdm{i_subject}{i_session}(i_mask).column.name(1:step:end)},'ytick',[]));
                set(gca(),'XTickLabelRotation',90);
            end
        end
        fig_fontname([],plot_args.fontname);
        fig_fontsize([],plot_args.fontsize);
    end
end
