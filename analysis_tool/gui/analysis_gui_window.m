% ANALYSIS internal script

%% gui
classdef analysis_gui_window < handle
    %% properties
    properties
        position
        size
        window
    end
    
    %% methods
    methods
        %% constructor
        function obj = analysis_gui_window(a)
            obj.create_window(a);
        end
        
        %% methods
        % create window
        function create_window(obj,a)
            obj.position = a.gui.win_position;
            obj.size     = [a.gui.win_size(1),10];
            obj.window   = figure(...
                'Color',a.gui.win_background,...
                'Name','ANALYSIS',...
                'Units','pixels',...
                'Position',[obj.position,obj.size],...
                'MenuBar','no',...
                'Resize','off',...
                'CloseRequestFcn',@a.destructor,...
                'Visible','off');
        end
        
        % resize
        function resize_window(obj,a)
            % height
            height = 0;
            height = height + a.obj.title.size(2);
            height = height + a.obj.figure.size(2);
            height = height + a.obj.sdata.size(2);
            height = height + a.obj.axis.size(2);
            height = height + a.obj.graphics.size(2);
            height = height + a.obj.plot.size(2);
            % size
            obj.size(2) = height;
            % window
            set(obj.window,'Position',[obj.position,obj.size]);
        end
        
        % resize
        function reposition_window(obj)
            % position
            pos = get(0,'ScreenSize');
            pos = reshape(pos,[2,2]);
            pos = mean(pos,2)';
            pos = pos - 0.5*obj.size;
            obj.position = pos;
            % window
            set(obj.window,'Position',[obj.position,obj.size]);
        end
        
        % show window
        function show_window(obj)
            set(obj.window,'Visible','on');
        end
    end
end
