
function obj = viewer_update_text(obj)
    %% obj = VIEWER_UPDATE_TEXT(obj)

    %% notes
    % this assumes it's always a t-map
    
    %% function
    disp('viewer_update_text');
    
    % get number of files
    u_file = get(findobj(obj.fig.control.figure,'Tag','FileList'),'Value');
    n_file = length(u_file);
    
    % MNI coordinates
    h = obj.fig.control.figure;
    x_edit = findobj(h,'Tag','XEdit');
    y_edit = findobj(h,'Tag','YEdit');
    z_edit = findobj(h,'Tag','ZEdit');
    x = str2double(get(x_edit,'String'));
    y = str2double(get(y_edit,'String'));
    z = str2double(get(z_edit,'String'));
    mni = [x,y,z];
    
    % map
    m_popup = findobj(h,'Tag','MapPopup');
    map = get(m_popup,'Value');
    
    % create new axes
    for i_file = 1:n_file
        file = u_file(i_file);
        
        % get native coordinates
        cor = aux_mni2cor(mni,obj.dat.statistics(file).matrix);
        cor = round(cor);

        % calculate statistics
        d = obj.dat.statistics(file).df;
        t = obj.dat.statistics(file).data(cor(1),cor(2),cor(3));
        
        switch map
            case 1
                p = 1-spm_Tcdf(t,d);
                set(obj.fig.viewer.text.pvalue(i_file),   'String',sprintf('p = %.4f', p));
                set(obj.fig.viewer.text.statistic(i_file),'String',sprintf('t_{%d} = %+.2f',d,t));
            case 2
                p = 1-spm_Fcdf(t,d);
                set(obj.fig.viewer.text.pvalue(i_file),   'String',sprintf('p = %.4f', p));
                set(obj.fig.viewer.text.statistic(i_file),'String',sprintf('f_{%d} = %+.2f',d,t));
            case 3
                p = t;
                t = spm_invTcdf(1-p,d);
                set(obj.fig.viewer.text.pvalue(i_file),   'String',sprintf('p = %.4f', p));
                set(obj.fig.viewer.text.statistic(i_file),'String',sprintf('t_{%d} = %+.2f',d,t));
            case 4
        end
        
    end
end
