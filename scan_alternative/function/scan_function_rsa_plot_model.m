
function scan = scan_function_rsa_plot_model(scan)
    %% scan = SCAN_FUNCTION_RSA_PLOT_MODEL(scan)
    % plot RDMs
    % to list main functions, try
    %   >> help scan;

    %% function
    if ~scan.running.flag.function, return; end
    
    scan_tool_print(scan,false,'\nAdd function (plot.model) : ');
    scan.function.plot.model = @auxiliar_plot_model;

    %% nested
    function auxiliar_plot_model(varargin)
        if ~any(ismember(nargin,1:3)) || strcmp(varargin{1},'help')
            scan_tool_help('@plot.model(i_model,u_subject,u_session)','This function plots the RDM from a certain model and a set of subjects/sessions. The model is an index that corresponds to a model (see [scan.job.model]). If [u_subject] or [u_session] are not specified, all available subjects/sessions are displayed. Any combination model/subject/session that doesn''t exist will be ignored.');
            return;
        end
        
        % default
        varargin(end+1:3) = {[]};
        [i_model,u_subject,u_session] = deal(varargin{1:3});
        func_default('u_subject',1:scan.running.subject.number);
        func_default('u_session',1:max(scan.running.subject.session));
        
        % assert
        if ~isscalar(i_model) || ~isnumeric(i_model), auxiliar_plot_model('help'); return; end
        if ~isnumeric(u_subject),                     auxiliar_plot_model('help'); return; end
        if ~isnumeric(u_session),                     auxiliar_plot_model('help'); return; end
        
        % plot
        fig_figure();
        for i_subject = 1:length(u_subject)
            for i_session = 1:length(u_session)
                if length(scan.running.model) < i_subject,                    continue; end
                if length(scan.running.model{i_subject}) < i_session,         continue; end
                if length(scan.running.model{i_subject}{i_session}) < i_model, continue; end
                subplot(length(u_subject),length(u_session),(i_subject-1)*length(u_session)+i_session);
                imagesc(squareform(scan.running.model{i_subject}{i_session}(i_model).vector));
                column = [scan.running.model{i_subject}{i_session}(i_model).column{:}]; column = {column.name};
                step = ceil((length(column)-1) ./ min(length(column)-1,20));
                fig_axis(struct('xtick',{1:step:length(column)},'xticklabel',{column(1:step:end)},'ytick',[]));
                set(gca(),'XTickLabelRotation',90);
            end
        end
        
    end
end
