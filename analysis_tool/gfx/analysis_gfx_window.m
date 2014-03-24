% ANALYSIS internal script

%% gfx
classdef analysis_gfx_window < handle
    %% properties
    properties
        position
        size
        window
    end
    
    %% methods
    methods
        %% constructor
        function obj = analysis_gfx_window(a)
            obj.create_window(a);
        end
        
        %% methods
        % create window
        function create_window(obj,a)
            obj.position = a.par.win_position;
            obj.size     = [a.par.win_size(1),10];
            obj.window   = figure(...
                'Color',a.par.win_background,...
                'Name','GRAPHICS',...
                'Units','pixels',...
                'Position',[obj.position,obj.size],...
                'MenuBar','no',...
                'Resize','off',...
                'CloseRequestFcn',@a.gfx_hold,...
                'Visible','off');
        end
        
        % resize
        function resize_window(obj,a)
            % height
            height = 0;
            height = height + a.gfx.title.size(2);
            height = height + a.gfx.style.size(2);
            height = height + a.gfx.colour.size(2);
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
            pos = pos - [0 , 0.5*obj.size(2)];
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
