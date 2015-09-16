
function obj = viewer_update_Clim(obj)
    %% obj = VIEWER_UPDATE_CLIM(obj)

    %% function
    disp('viewer_update_Clim');
    
    % get number of files
    x_file = get(findobj(obj.fig.control.figure,'Tag','FileList'),'Value');
    n_file = length(x_file);
    
    % get range
    clim = [0,0];
    for i_file = 1:n_file
        
        % load volume
        v_data = obj.dat.statistics(x_file(i_file)).data;
        
        % get range
        r_data = ranger(v_data);
        
        % update clim
        clim(1) = min(r_data(1),clim(1));
        clim(2) = max(r_data(2),clim(2));
    end

    % tail
    if get(findobj(obj.fig.control.figure,'Tag','PositiveRadio'),'Value')
        clim(clim<0) = 0;
        if isequal(clim,[0,0]), return; end
    elseif get(findobj(obj.fig.control.figure,'Tag','NegativeRadio'),'Value')
        clim(clim>0) = 0;
        if isequal(clim,[0,0]), return; end
    else
        clim = max(abs(clim)) * [-1,+1];
        if isequal(clim,[0,0]), return; end
    end

    % calculate the slice for the POV
    set(obj.fig.viewer.axis,'CLim',clim);
    set(obj.fig.viewer.colorbar.axis,'CLim',clim);
end
