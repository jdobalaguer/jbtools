
function obj = viewer_update_map(obj)
    %% obj = VIEWER_UPDATE_MAP(obj)

    %% notes
    % 1. what to show depends on the statistics (whether it's p-map in particular)
    
    %% function
    disp('viewer_update_map');
    
    % get number of files
    x_file = get(findobj(obj.fig.control.figure,'Tag','FileList'),'Value');
    n_file = length(x_file);
    
    % coordinate
    x = str2double(get(findobj(obj.fig.control.figure,'Tag','XEdit'),'String'));
    y = str2double(get(findobj(obj.fig.control.figure,'Tag','YEdit'),'String'));
    z = str2double(get(findobj(obj.fig.control.figure,'Tag','ZEdit'),'String'));
    
    % template
    template = get(findobj(obj.fig.control.figure,'Tag','BackgroundPopup'),'Value');
    template = obj.dat.templates(template).volume;
    
    % update background/statistics
    for i_pov = 1:3
        for i_file = 1:n_file
            
            % load volume
            vol = obj.dat.volumes{x_file(i_file)};
            
            % mask statistics
            img = nan(size(vol));
            tmin = str2double(get(findobj(obj.fig.control.figure,'Tag','StatEdit'),'string'));
            img(vol(:) < -tmin) = vol(vol(:) <= -tmin);
            img(vol(:) > +tmin) = vol(vol(:) >= +tmin);
            
            % display
            switch i_pov
                case 1
                    set(obj.fig.viewer.background(i_pov,i_file),'CData',repmat(squeeze(template(x,:,:))',[1,1,3]));
                    set(obj.fig.viewer.statistics(i_pov,i_file),'CData',squeeze(img(x,:,:))');
                case 2
                    set(obj.fig.viewer.background(i_pov,i_file),'CData',repmat(squeeze(template(:,y,:))',[1,1,3]));
                    set(obj.fig.viewer.statistics(i_pov,i_file),'CData',squeeze(img(:,y,:))');
                case 3
                    set(obj.fig.viewer.background(i_pov,i_file),'CData',repmat(squeeze(template(:,:,z)), [1,1,3]));
                    set(obj.fig.viewer.statistics(i_pov,i_file),'CData',squeeze(img(:,:,z)));
            end
        end
    end
end
