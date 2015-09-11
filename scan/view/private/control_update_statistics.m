
function obj = control_update_statistics(obj,edit)
    %% obj = CONTROL_UPDATE_STATISTICS(obj,edit)
    
    %% notes
    % 1. it currently ignores whether it's one- or two-tailed
    % 2. need to implement the FDR, see @spm_P_FDR
    % 3. control that the p-value is in [0,1]
    
    %% function
    disp('control_update_statistics');
    
    % handles
    h = obj.fig.control.figure;
    t_edit  = findobj(obj.fig.control.figure,'Tag','StatEdit');
    p_edit  = findobj(obj.fig.control.figure,'Tag','PValueEdit');
    f_edit  = findobj(obj.fig.control.figure,'Tag','FDREdit');
    d_edit  = findobj(h,'Tag','DFEdit');
    m_popup = findobj(h,'Tag','MapPopup');
    
    % statistics
    t = str2double(get(t_edit,'String'));
    p = str2double(get(p_edit,'String'));
    f = str2double(get(f_edit,'String'));
    d = str2double(get(d_edit,'String'));
    
    % if function invoked as a callback, find the edit that launched it
    func_default('edit',nan);
    switch edit
        case t_edit, [p,f] = deal(nan);
        case p_edit, [t,f] = deal(nan);
        case f_edit, [t,p] = deal(nan);
    end
    
    % map
    u_m = get(m_popup,'String');
    i_m = get(m_popup,'Value');
    m = u_m{i_m};
    
    % no statistics
    if isnan(d), set(m_popup,'Value',find(strcmp(u_m,'none'))); return; end
    if strcmp(m,'none'), return; end
    
    % update statistic
    if ~isnan(p)
        % based on p-value
        switch m
            case 't-map', t = spm_invTcdf(1-p,d);
            case 'f-map', t = spm_invFcdf(1-p,d);
            case 'p-map', t = spm_invTcdf(1-p,d);
        end
        f = nan;
    elseif ~isnan(t)
        % based on statistic
        switch m
            case 't-map', p = 1-spm_Tcdf(t,d);
            case 'f-map', p = 1-spm_Fcdf(t,d);
            case 'p-map', p = 1-spm_Tcdf(T,d);
        end
        f = nan;
    elseif ~isnan(t)
        % based on FDR
        % TODO
        [t,p,f] = deal(nan); 
    else
        % something weird, put all to nan
        scan_tool_warning(obj.dat.scan,false,'no statistic specified - statistic map disabled');
        set(m_popup,'Value',find(strcmp(u_m,'none')));
        [t,p,f] = deal(nan); 
    end
    set(t_edit,'String',sprintf('%+.2f',t));
    set(p_edit,'String',sprintf('%.1e', p));
    set(f_edit,'String',sprintf('%+.2f',f));
end
