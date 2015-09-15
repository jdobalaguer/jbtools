
function obj = viewer_create_line(obj)
    %% obj = VIEWER_CREATE_LINE(obj)

    %% function
    disp('viewer_create_line');
    
    % get number of files
    n_file = length(get(findobj(obj.fig.control.figure,'Tag','FileList'),'Value'));
    
    % remove previous lines
    delete(obj.fig.viewer.line.x);
    delete(obj.fig.viewer.line.y);
    
    % print background
    obj.fig.viewer.line.x = repmat(matlab.graphics.primitive.Line,3,n_file); % create line matrix
    obj.fig.viewer.line.y = repmat(matlab.graphics.primitive.Line,3,n_file); % create line matrix
    delete(obj.fig.viewer.line.x); delete(obj.fig.viewer.line.y);
    for i_pov = 1:3
        for i_file = 1:n_file
            
            % axis and colour
            a = obj.fig.viewer.axis(i_pov,i_file);
            c = obj.par.viewer.line.color;
            
            % create lines
            switch i_pov
                case 1
                    obj.fig.viewer.line.x(i_pov,i_file) = line(nan,nan,'Color',c,'LineWidth',obj.par.viewer.line.thickness,'Parent',a);
                    obj.fig.viewer.line.y(i_pov,i_file) = line(nan,nan,'Color',c,'LineWidth',obj.par.viewer.line.thickness,'Parent',a);
                case 2
                    obj.fig.viewer.line.x(i_pov,i_file) = line(nan,nan,'Color',c,'LineWidth',obj.par.viewer.line.thickness,'Parent',a);
                    obj.fig.viewer.line.y(i_pov,i_file) = line(nan,nan,'Color',c,'LineWidth',obj.par.viewer.line.thickness,'Parent',a);
                case 3
                    obj.fig.viewer.line.x(i_pov,i_file) = line(nan,nan,'Color',c,'LineWidth',obj.par.viewer.line.thickness,'Parent',a);
                    obj.fig.viewer.line.y(i_pov,i_file) = line(nan,nan,'Color',c,'LineWidth',obj.par.viewer.line.thickness,'Parent',a);
            end
        end
    end
end
