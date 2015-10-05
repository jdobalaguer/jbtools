
function masked = aux_maskStatistics(obj,volume)
    %% obj = AUX_MASKSTATISTICS(obj,volume)
    % return a volume based on the threshold setting in the control window.

    %% function
    
    % mask statistics
    masked = nan(size(volume));
    tmin = str2double(get(findobj(obj.fig.control.figure,'Tag','StatEdit'),'string'));
    if get(findobj(obj.fig.control.figure,'Tag','PositiveRadio'),'Value')
        masked(volume(:) >= +tmin) = volume(volume(:) >= +tmin);
    elseif get(findobj(obj.fig.control.figure,'Tag','NegativeRadio'),'Value')
        masked(volume(:) <= -tmin) = volume(volume(:) <= -tmin);
    elseif get(findobj(obj.fig.control.figure,'Tag','BothRadio'),'Value')
        masked(volume(:) >= +tmin) = volume(volume(:) >= +tmin);
        masked(volume(:) <= -tmin) = volume(volume(:) <= -tmin);
    else
        scan_tool_warning(obj.scan,false,'no tail selected');
    end
end
